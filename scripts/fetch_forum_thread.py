#!/usr/bin/env python3
"""
Script to fetch all posts from the Mach4 Lua capabilities forum thread.
Forum thread: https://forum.avidcnc.com/t/mach-4-lua-capabilities/1308
"""

import requests
from bs4 import BeautifulSoup
import time
import re
from pathlib import Path

def fetch_page(url, page_num=None):
    """Fetch a single page from the forum thread."""
    if page_num:
        page_url = f"{url}?page={page_num}"
    else:
        page_url = url
    
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    
    try:
        response = requests.get(page_url, headers=headers)
        response.raise_for_status()
        return response.text
    except requests.RequestException as e:
        print(f"Error fetching page {page_num or 1}: {e}")
        return None

def parse_posts(html_content):
    """Extract posts from HTML content."""
    import json
    import html
    
    soup = BeautifulSoup(html_content, 'html.parser')
    posts = []
    
    print("Looking for preloaded data...")
    
    # Look for the data-preloaded div that contains JSON data
    preloaded_div = soup.find('div', {'id': 'data-preloaded'})
    if preloaded_div and preloaded_div.get('data-preloaded'):
        try:
            # Decode the HTML-escaped JSON
            json_data = html.unescape(preloaded_div.get('data-preloaded'))
            data = json.loads(json_data)
            
            # Find the topic data
            for key, value in data.items():
                if key.startswith('topic_'):
                    topic_data = json.loads(value)
                    post_stream = topic_data.get('post_stream', {})
                    posts_data = post_stream.get('posts', [])
                    
                    print(f"Found {len(posts_data)} posts in JSON data")
                    
                    for post_data in posts_data:
                        # Clean up the HTML content
                        content = post_data.get('cooked', '')
                        if content:
                            content_soup = BeautifulSoup(content, 'html.parser')
                            content = content_soup.get_text(separator='\n', strip=True)
                        
                        post = {
                            'number': str(post_data.get('post_number', 'Unknown')),
                            'username': post_data.get('display_username') or post_data.get('username', 'Unknown User'),
                            'timestamp': post_data.get('created_at', 'Unknown Time'),
                            'content': content or 'Content not found'
                        }
                        posts.append(post)
                    
                    break
        except (json.JSONDecodeError, KeyError) as e:
            print(f"Error parsing JSON data: {e}")
            # Fall back to HTML parsing if JSON fails
            return parse_posts_fallback(soup)
    
    if not posts:
        print("No posts found in JSON data, falling back to HTML parsing...")
        return parse_posts_fallback(soup)
    
    return posts

def parse_posts_fallback(soup):
    """Fallback HTML parsing method."""
    posts = []
    
    # Try multiple selectors for Discourse forum posts
    selectors_to_try = [
        'article[data-post-id]',
        'article.topic-post',
        '.topic-post',
        '[data-post-id]',
        '.post-stream .topic-post',
        '.post'
    ]
    
    post_elements = []
    for selector in selectors_to_try:
        elements = soup.select(selector)
        print(f"Selector '{selector}' found {len(elements)} elements")
        if elements:
            post_elements = elements
            break
    
    for post_elem in post_elements:
        try:
            # Extract post number
            post_number_elem = post_elem.find('span', class_='post-number')
            post_number = post_number_elem.text.strip() if post_number_elem else "Unknown"
            
            # Extract username
            username_elem = post_elem.find('span', class_='username')
            if not username_elem:
                username_elem = post_elem.find('a', {'data-user-card': True})
            username = username_elem.text.strip() if username_elem else "Unknown User"
            
            # Extract timestamp
            time_elem = post_elem.find('time') or post_elem.find('span', class_='relative-date')
            timestamp = time_elem.get('datetime') if time_elem and time_elem.get('datetime') else \
                       time_elem.text.strip() if time_elem else "Unknown Time"
            
            # Extract post content
            content_elem = post_elem.find('div', class_='cooked')
            if content_elem:
                # Clean up the content
                content = content_elem.get_text(separator='\n', strip=True)
            else:
                content = "Content not found"
            
            posts.append({
                'number': post_number,
                'username': username,
                'timestamp': timestamp,
                'content': content
            })
            
        except Exception as e:
            print(f"Error parsing post: {e}")
            continue
    
    return posts

def format_posts_as_markdown(posts, thread_title):
    """Convert posts to markdown format."""
    markdown_content = f"# {thread_title}\n\n"
    markdown_content += f"Total posts: {len(posts)}\n\n"
    markdown_content += "---\n\n"
    
    for post in posts:
        markdown_content += f"## Post #{post['number']} - {post['username']}\n\n"
        markdown_content += f"**Time:** {post['timestamp']}\n\n"
        markdown_content += f"{post['content']}\n\n"
        markdown_content += "---\n\n"
    
    return markdown_content

def main():
    base_url = "https://forum.avidcnc.com/t/mach-4-lua-capabilities/1308"
    thread_title = "Mach 4 Lua Capabilities"
    all_posts = []
    
    print("Fetching forum thread: Mach 4 Lua Capabilities")
    print("Target: 88 posts")
    
    # Start with page 1
    page = 1
    max_pages = 10  # Safety limit
    
    while page <= max_pages:
        print(f"Fetching page {page}...")
        
        html_content = fetch_page(base_url, page if page > 1 else None)
        if not html_content:
            break
        
        posts = parse_posts(html_content)
        if not posts:
            print(f"No posts found on page {page}, stopping.")
            break
        
        all_posts.extend(posts)
        print(f"Found {len(posts)} posts on page {page}. Total so far: {len(all_posts)}")
        
        # Check if we have 88 posts or if this might be the last page
        if len(all_posts) >= 88:
            print("Reached target of 88 posts!")
            break
        
        # Check if there's a next page link
        soup = BeautifulSoup(html_content, 'html.parser')
        next_link = soup.find('a', string=re.compile(r'next page', re.I))
        if not next_link:
            print("No next page link found, stopping.")
            break
        
        page += 1
        time.sleep(1)  # Be respectful to the server
    
    print(f"\nTotal posts collected: {len(all_posts)}")
    
    # Convert to markdown
    markdown_content = format_posts_as_markdown(all_posts, thread_title)
    
    # Save to research directory
    research_dir = Path(__file__).parent.parent / "research"
    research_dir.mkdir(exist_ok=True)
    
    output_file = research_dir / "mach-4-lua-capabilities.md"
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(markdown_content)
    
    print(f"Content saved to: {output_file}")
    print(f"File contains {len(all_posts)} posts")
    
    if len(all_posts) == 88:
        print("✓ Successfully collected all 88 posts!")
    else:
        print(f"⚠ Expected 88 posts but got {len(all_posts)}")

if __name__ == "__main__":
    main()