#!/usr/bin/env python3
"""
YouTube Transcript Downloader for Mach4 Research Project

Downloads transcripts from YouTube videos and playlists, saving them as markdown files
in the research directory. Supports individual videos and entire playlists.

Requirements:
    pip install youtube-transcript-api

Usage:
    python scripts/youtube_transcripts.py <URL>
    
Examples:
    python scripts/youtube_transcripts.py "https://www.youtube.com/watch?v=VIDEO_ID"
    python scripts/youtube_transcripts.py "https://www.youtube.com/playlist?list=PLAYLIST_ID"
"""

import argparse
import os
import re
import sys
from pathlib import Path
from urllib.parse import parse_qs, urlparse
from typing import List, Dict, Optional

try:
    from youtube_transcript_api import YouTubeTranscriptApi
    from youtube_transcript_api._errors import TranscriptsDisabled, NoTranscriptFound
except ImportError:
    print("Error: youtube-transcript-api not installed.")
    print("Install with: pip install youtube-transcript-api")
    sys.exit(1)

# For playlist support, we'll need additional functionality
try:
    import requests
    HAS_REQUESTS = True
except ImportError:
    HAS_REQUESTS = False
    print("Warning: requests not installed. Playlist support limited.")

try:
    import yt_dlp
    HAS_YT_DLP = True
except ImportError:
    HAS_YT_DLP = False
    print("Warning: yt-dlp not installed. Video metadata will be limited.")


class YouTubeTranscriptDownloader:
    def __init__(self, output_dir: str = "research/transcripts"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
    
    def extract_video_id(self, url: str) -> Optional[str]:
        """Extract video ID from various YouTube URL formats."""
        patterns = [
            r'(?:youtube\.com/watch\?v=|youtu\.be/|youtube\.com/embed/)([^&\n?#]+)',
            r'youtube\.com/watch\?.*v=([^&\n?#]+)'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, url)
            if match:
                return match.group(1)
        return None
    
    def extract_playlist_id(self, url: str) -> Optional[str]:
        """Extract playlist ID from YouTube playlist URL."""
        parsed = urlparse(url)
        if 'list' in parse_qs(parsed.query):
            return parse_qs(parsed.query)['list'][0]
        return None
    
    def get_video_metadata(self, video_id: str) -> Dict[str, str]:
        """Get comprehensive video metadata using yt-dlp."""
        if not HAS_YT_DLP:
            return {
                'title': f"Video_{video_id}",
                'video_id': video_id,
                'url': f"https://www.youtube.com/watch?v={video_id}",
                'uploader': 'Unknown',
                'upload_date': 'Unknown',
                'duration': 'Unknown',
                'view_count': 'Unknown',
                'description': 'yt-dlp not available'
            }
        
        try:
            ydl_opts = {
                'quiet': True,
                'no_warnings': True,
                'extract_flat': False
            }
            
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                info = ydl.extract_info(f"https://www.youtube.com/watch?v={video_id}", download=False)
                
                # Format duration from seconds to readable format
                duration_seconds = info.get('duration', 0)
                if duration_seconds:
                    minutes, seconds = divmod(duration_seconds, 60)
                    duration_formatted = f"{minutes}:{seconds:02d}"
                else:
                    duration_formatted = "Unknown"
                
                # Format upload date
                upload_date = info.get('upload_date', '')
                if upload_date and len(upload_date) == 8:
                    upload_date_formatted = f"{upload_date[:4]}-{upload_date[4:6]}-{upload_date[6:]}"
                else:
                    upload_date_formatted = upload_date or "Unknown"
                
                # Format view count
                view_count = info.get('view_count', 0)
                view_count_formatted = f"{view_count:,}" if view_count else "Unknown"
                
                return {
                    'title': info.get('title', f"Video_{video_id}"),
                    'video_id': video_id,
                    'url': f"https://www.youtube.com/watch?v={video_id}",
                    'uploader': info.get('uploader', 'Unknown'),
                    'upload_date': upload_date_formatted,
                    'duration': duration_formatted,
                    'view_count': view_count_formatted,
                    'description': info.get('description', '')[:500] + ('...' if len(info.get('description', '')) > 500 else '')
                }
                
        except Exception as e:
            print(f"Warning: Could not fetch metadata for {video_id}: {str(e)}")
            return {
                'title': f"Video_{video_id}",
                'video_id': video_id,
                'url': f"https://www.youtube.com/watch?v={video_id}",
                'uploader': 'Unknown',
                'upload_date': 'Unknown',
                'duration': 'Unknown',
                'view_count': 'Unknown',
                'description': 'Could not fetch metadata'
            }
    
    def sanitize_filename(self, filename: str) -> str:
        """Sanitize filename for filesystem compatibility."""
        # Remove or replace invalid characters
        filename = re.sub(r'[<>:"/\\|?*]', '_', filename)
        filename = re.sub(r'\s+', '_', filename)
        return filename[:100]  # Limit length
    
    def download_transcript(self, video_id: str, output_path: Optional[Path] = None) -> bool:
        """Download transcript for a single video."""
        try:
            # Get transcript
            api = YouTubeTranscriptApi()
            fetched_transcript = api.fetch(video_id)
            
            # Convert to expected format
            transcript_list = []
            for snippet in fetched_transcript.snippets:
                transcript_list.append({
                    'text': snippet.text,
                    'start': snippet.start,
                    'duration': snippet.duration
                })
            
            # Get metadata
            metadata = self.get_video_metadata(video_id)
            
            # Create filename using video title
            safe_title = self.sanitize_filename(metadata['title'])
            filename = f"{safe_title}.md"
            
            if output_path:
                file_path = output_path / filename
            else:
                file_path = self.output_dir / filename
            
            # Format transcript as markdown
            markdown_content = self.format_transcript_as_markdown(
                transcript_list, metadata
            )
            
            # Write to file
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(markdown_content)
            
            print(f"✓ Downloaded: {filename}")
            return True
            
        except TranscriptsDisabled:
            print(f"✗ Transcripts disabled for video: {video_id}")
            return False
        except NoTranscriptFound:
            print(f"✗ No transcript found for video: {video_id}")
            return False
        except Exception as e:
            print(f"✗ Error downloading {video_id}: {str(e)}")
            return False
    
    def format_transcript_as_markdown(self, transcript: List[Dict], metadata: Dict[str, str]) -> str:
        """Format transcript data as markdown."""
        content = []
        
        # Header
        content.append(f"# {metadata['title']}")
        content.append("")
        
        # Metadata section
        content.append("## Video Information")
        content.append("")
        content.append(f"- **Video ID:** {metadata['video_id']}")
        content.append(f"- **URL:** {metadata['url']}")
        content.append(f"- **Channel:** {metadata['uploader']}")
        content.append(f"- **Upload Date:** {metadata['upload_date']}")
        content.append(f"- **Duration:** {metadata['duration']}")
        content.append(f"- **View Count:** {metadata['view_count']}")
        content.append(f"- **Downloaded:** {self.get_current_timestamp()}")
        content.append("")
        
        # Description section
        if metadata.get('description') and metadata['description'].strip() and metadata['description'] != 'Could not fetch metadata':
            content.append("## Description")
            content.append("")
            content.append(metadata['description'])
            content.append("")
        
        content.append("---")
        content.append("")
        content.append("## Transcript")
        content.append("")
        
        # Transcript content
        current_text = []
        for entry in transcript:
            text = entry['text'].strip()
            if text:
                current_text.append(text)
                
                # Break into paragraphs at natural points
                if (text.endswith('.') or text.endswith('!') or text.endswith('?') or 
                    len(' '.join(current_text)) > 200):
                    content.append(' '.join(current_text))
                    content.append("")
                    current_text = []
        
        # Add any remaining text
        if current_text:
            content.append(' '.join(current_text))
            content.append("")
        
        return '\n'.join(content)
    
    def get_current_timestamp(self) -> str:
        """Get current timestamp for metadata."""
        from datetime import datetime
        return datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    def get_playlist_videos(self, playlist_id: str) -> List[str]:
        """Get video IDs from playlist using yt-dlp."""
        if not HAS_YT_DLP:
            print(f"Warning: yt-dlp not available. Cannot extract playlist videos.")
            return []
        
        try:
            ydl_opts = {
                'quiet': True,
                'no_warnings': True,
                'extract_flat': True,
                'dump_single_json': True
            }
            
            playlist_url = f"https://www.youtube.com/playlist?list={playlist_id}"
            
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                info = ydl.extract_info(playlist_url, download=False)
                
                video_ids = []
                if 'entries' in info:
                    for entry in info['entries']:
                        if entry and 'id' in entry:
                            video_ids.append(entry['id'])
                
                print(f"Found {len(video_ids)} videos in playlist {playlist_id}")
                return video_ids
                
        except Exception as e:
            print(f"Error extracting playlist videos: {str(e)}")
            return []
    
    def process_url(self, url: str) -> bool:
        """Process a single URL (video or playlist)."""
        # Check if it's a playlist
        playlist_id = self.extract_playlist_id(url)
        if playlist_id:
            print(f"Detected playlist: {playlist_id}")
            video_ids = self.get_playlist_videos(playlist_id)
            
            if not video_ids:
                print("Could not extract videos from playlist. Try individual video URLs.")
                return False
            
            # Download all videos to the main transcripts directory
            success_count = 0
            for video_id in video_ids:
                if self.download_transcript(video_id):
                    success_count += 1
            
            print(f"Downloaded {success_count}/{len(video_ids)} transcripts from playlist")
            return success_count > 0
        
        # Single video
        video_id = self.extract_video_id(url)
        if not video_id:
            print(f"Could not extract video ID from URL: {url}")
            return False
        
        return self.download_transcript(video_id)


def main():
    parser = argparse.ArgumentParser(
        description="Download YouTube video transcripts for Mach4 research"
    )
    parser.add_argument(
        "url",
        help="YouTube video or playlist URL"
    )
    parser.add_argument(
        "--output-dir", "-o",
        default="research/transcripts",
        help="Output directory for transcripts (default: research/transcripts)"
    )
    
    args = parser.parse_args()
    
    # Initialize downloader
    downloader = YouTubeTranscriptDownloader(args.output_dir)
    
    # Process URL
    success = downloader.process_url(args.url)
    
    if success:
        print(f"\nTranscripts saved to: {downloader.output_dir}")
    else:
        print("\nFailed to download transcripts")
        sys.exit(1)


if __name__ == "__main__":
    main()