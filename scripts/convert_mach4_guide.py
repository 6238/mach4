#!/usr/bin/env python3
"""
Convert Mach4 CNC Controller Lua Scripting Guide from JSON to Markdown files.

This script converts the JSON export of the Mach4 scripting guide into a set of
well-organized Markdown files with proper navigation links and image references.
"""

import json
import os
import re
import shutil
from pathlib import Path
from html import unescape
from urllib.parse import unquote


def html_to_markdown(html_content):
    """Convert HTML content to Markdown with basic formatting."""
    if not html_content:
        return ""
    
    # Unescape HTML entities
    content = unescape(html_content)
    
    # Remove HTML comments
    content = re.sub(r'<!--.*?-->', '', content, flags=re.DOTALL)
    
    # Convert headers
    content = re.sub(r'<h1[^>]*>(.*?)</h1>', r'# \1', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<h2[^>]*>(.*?)</h2>', r'## \1', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<h3[^>]*>(.*?)</h3>', r'### \1', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<h4[^>]*>(.*?)</h4>', r'#### \1', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<h5[^>]*>(.*?)</h5>', r'##### \1', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<h6[^>]*>(.*?)</h6>', r'###### \1', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Convert paragraphs
    content = re.sub(r'<p[^>]*>(.*?)</p>', r'\1\n\n', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Convert line breaks
    content = re.sub(r'<br\s*/?>', '\n', content, flags=re.IGNORECASE)
    
    # Convert emphasis and strong
    content = re.sub(r'<strong[^>]*>(.*?)</strong>', r'**\1**', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<b[^>]*>(.*?)</b>', r'**\1**', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<em[^>]*>(.*?)</em>', r'*\1*', content, flags=re.IGNORECASE | re.DOTALL)
    content = re.sub(r'<i[^>]*>(.*?)</i>', r'*\1*', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Convert code spans
    content = re.sub(r'<code[^>]*>(.*?)</code>', r'`\1`', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Convert lists
    content = re.sub(r'<ul[^>]*>', '', content, flags=re.IGNORECASE)
    content = re.sub(r'</ul>', '\n', content, flags=re.IGNORECASE)
    content = re.sub(r'<ol[^>]*>', '', content, flags=re.IGNORECASE)
    content = re.sub(r'</ol>', '\n', content, flags=re.IGNORECASE)
    content = re.sub(r'<li[^>]*>(.*?)</li>', r'- \1\n', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Convert links
    content = re.sub(r'<a[^>]*href=["\']([^"\']*)["\'][^>]*>(.*?)</a>', r'[\2](\1)', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Handle image references
    content = re.sub(r'<img[^>]*src=["\']?\[\[bsexport:image:(\d+)\]\]["\']?[^>]*>', r'![Image \1](images/image_\1.png)', content, flags=re.IGNORECASE)
    content = re.sub(r'<img[^>]*src=["\']([^"\']*)["\'][^>]*>', r'![](\1)', content, flags=re.IGNORECASE)
    
    # Remove remaining HTML tags
    content = re.sub(r'<[^>]+>', '', content)
    
    # Clean up whitespace
    content = re.sub(r'\n\s*\n\s*\n', '\n\n', content)
    content = re.sub(r'^\s+', '', content, flags=re.MULTILINE)
    content = content.strip()
    
    # Convert HTML entities that might remain
    content = content.replace('&nbsp;', ' ')
    content = content.replace('&amp;', '&')
    content = content.replace('&lt;', '<')
    content = content.replace('&gt;', '>')
    content = content.replace('&quot;', '"')
    content = content.replace('&#39;', "'")
    
    return content


def create_filename(page_name):
    """Create a safe filename from page name."""
    # Remove numbers and clean up the name
    name = re.sub(r'^\d+\s*', '', page_name)
    name = re.sub(r'[^\w\s-]', '', name)
    name = re.sub(r'\s+', '_', name.strip())
    name = name.lower()
    return f"{name}.md"


def copy_images(source_dir, target_dir, images_list):
    """Copy images from source directory to target images directory."""
    images_dir = target_dir / "images"
    images_dir.mkdir(exist_ok=True)
    
    copied_images = []
    
    for image in images_list:
        image_id = image.get('id')
        image_file = image.get('file')
        image_name = image.get('name', f'image_{image_id}')
        
        if image_file:
            # Look for the image file in the source directory and files subdirectory
            source_file = source_dir / image_file
            if not source_file.exists():
                source_file = source_dir / "files" / image_file
            
            if source_file.exists():
                # Use original extension if available, otherwise default to png
                file_ext = source_file.suffix if source_file.suffix else '.png'
                target_file = images_dir / f"image_{image_id}{file_ext}"
                shutil.copy2(source_file, target_file)
                copied_images.append(f"image_{image_id}{file_ext}")
                print(f"Copied image: {image_file} -> {target_file.name}")
            else:
                print(f"Warning: Image file not found: {image_file}")
    
    return copied_images


def create_navigation_links(pages, current_page_index):
    """Create navigation links for a page."""
    links = []
    
    # Previous page
    if current_page_index > 0:
        prev_page = pages[current_page_index - 1]
        prev_filename = create_filename(prev_page['name'])
        links.append(f"← [Previous: {prev_page['name']}]({prev_filename})")
    
    # Next page
    if current_page_index < len(pages) - 1:
        next_page = pages[current_page_index + 1]
        next_filename = create_filename(next_page['name'])
        links.append(f"[Next: {next_page['name']}]({next_filename}) →")
    
    # Always include link to table of contents
    if current_page_index != 0:  # Don't add TOC link to TOC page itself
        links.append(f"[📋 Table of Contents](table_of_contents.md)")
    
    return " | ".join(links) if links else ""


def convert_guide_to_markdown(json_file_path, output_dir):
    """Convert the JSON guide to Markdown files."""
    # Load the JSON data
    with open(json_file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    chapter = data['chapter']
    pages = sorted(chapter['pages'], key=lambda x: x['priority'])
    
    # Create output directory
    output_path = Path(output_dir)
    output_path.mkdir(exist_ok=True)
    
    # Copy images from source directory
    source_dir = Path(json_file_path).parent
    all_images = []
    for page in pages:
        all_images.extend(page.get('images', []))
    
    copied_images = copy_images(source_dir, output_path, all_images)
    
    # Convert each page to Markdown
    markdown_files = []
    
    for i, page in enumerate(pages):
        page_name = page['name']
        page_html = page['html']
        
        # Create filename
        filename = create_filename(page_name)
        markdown_files.append((filename, page_name))
        
        # Convert HTML to Markdown
        markdown_content = html_to_markdown(page_html)
        
        # Create navigation
        nav_links = create_navigation_links(pages, i)
        
        # Build the complete markdown file
        full_content = f"# {page_name}\n\n"
        
        if nav_links:
            full_content += f"---\n**Navigation:** {nav_links}\n---\n\n"
        
        full_content += markdown_content
        
        if nav_links:
            full_content += f"\n\n---\n**Navigation:** {nav_links}\n---"
        
        # Write the file
        output_file = output_path / filename
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(full_content)
        
        print(f"Created: {filename}")
    
    # Create main README file
    readme_content = f"""# {chapter['name']}

This directory contains the complete Mach4 CNC Controller Lua Scripting Guide converted to Markdown format for easy reading and searching.

## Quick Start

Start reading from the [Table of Contents](table_of_contents.md) or jump to any section below:

## Pages

"""
    
    for filename, page_name in markdown_files:
        readme_content += f"- [{page_name}]({filename})\n"
    
    readme_content += f"""
## Images

This guide includes {len(copied_images)} images located in the `images/` directory.

## About This Conversion

This guide was automatically converted from the original JSON export format to Markdown for better readability and searchability. Each page includes navigation links to move between sections easily.

Generated from: `{Path(json_file_path).name}`
"""
    
    readme_file = output_path / "README.md"
    with open(readme_file, 'w', encoding='utf-8') as f:
        f.write(readme_content)
    
    print(f"\nConversion complete!")
    print(f"Created {len(markdown_files)} markdown files")
    print(f"Copied {len(copied_images)} images")
    print(f"Output directory: {output_path}")
    print(f"Start reading from: {readme_file}")


def main():
    """Main function to run the conversion."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Convert Mach4 guide JSON to Markdown')
    parser.add_argument('json_file', help='Path to the JSON file')
    parser.add_argument('-o', '--output', default='mach4_guide_markdown', 
                       help='Output directory name (default: mach4_guide_markdown)')
    
    args = parser.parse_args()
    
    if not os.path.exists(args.json_file):
        print(f"Error: JSON file not found: {args.json_file}")
        return 1
    
    try:
        convert_guide_to_markdown(args.json_file, args.output)
        return 0
    except Exception as e:
        print(f"Error during conversion: {e}")
        return 1


if __name__ == '__main__':
    exit(main())