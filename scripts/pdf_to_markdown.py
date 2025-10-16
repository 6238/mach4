#!/usr/bin/env python3
"""
PDF to Markdown Converter for Mach4 API Documentation

This script converts PDF files to Markdown format, preserving structure and formatting
for easier use in Claude Code development workflows.
"""

import os
import sys
import argparse
from pathlib import Path
import PyPDF2
import re


class PDFToMarkdownConverter:
    def __init__(self):
        # Set output directory relative to project root
        script_dir = Path(__file__).parent
        project_root = script_dir.parent
        self.output_dir = project_root / "research" / "pdf_conversions"
        
    def setup_output_directory(self):
        """Create output directory if it doesn't exist"""
        Path(self.output_dir).mkdir(parents=True, exist_ok=True)
    
    def clean_text(self, text):
        """Clean and format extracted text"""
        # Remove excessive whitespace
        text = re.sub(r'\n\s*\n\s*\n', '\n\n', text)
        text = re.sub(r'[ \t]+', ' ', text)
        
        # Fix common OCR issues
        text = re.sub(r'([a-z])([A-Z])', r'\1 \2', text)  # Add space between camelCase
        text = re.sub(r'(\w)(\d)', r'\1 \2', text)  # Add space between word and number
        text = re.sub(r'(\d)(\w)', r'\1 \2', text)  # Add space between number and word
        
        return text.strip()
    
    def extract_headings(self, text_dict):
        """Extract headings based on font size"""
        headings = []
        for block in text_dict.get("blocks", []):
            if "lines" in block:
                for line in block["lines"]:
                    for span in line["spans"]:
                        font_size = span.get("size", 0)
                        text = span.get("text", "").strip()
                        if text and font_size > 12:  # Likely a heading
                            headings.append((text, font_size))
        return headings
    
    def format_as_markdown(self, text, headings_info=None):
        """Convert extracted text to Markdown format"""
        lines = text.split('\n')
        markdown_lines = []
        
        for line in lines:
            line = line.strip()
            if not line:
                markdown_lines.append('')
                continue
                
            # Check if line looks like a heading
            if self.is_likely_heading(line):
                # Determine heading level based on content and position
                if any(keyword in line.lower() for keyword in ['chapter', 'section', 'api reference']):
                    markdown_lines.append(f'# {line}')
                elif line.isupper() or (len(line) < 50 and not line.endswith('.')):
                    markdown_lines.append(f'## {line}')
                else:
                    markdown_lines.append(f'### {line}')
            # Check for code blocks or API signatures
            elif self.is_code_like(line):
                if not markdown_lines or not markdown_lines[-1].startswith('```'):
                    markdown_lines.append('```')
                markdown_lines.append(line)
                if len(markdown_lines) > 1 and markdown_lines[-2].startswith('```') and not markdown_lines[-2] == '```':
                    markdown_lines.append('```')
            # Check for lists
            elif re.match(r'^\s*[-•*]\s+', line) or re.match(r'^\s*\d+\.\s+', line):
                markdown_lines.append(line)
            # Regular paragraph text
            else:
                markdown_lines.append(line)
        
        return '\n'.join(markdown_lines)
    
    def is_likely_heading(self, text):
        """Determine if text is likely a heading"""
        if len(text) > 100:
            return False
        if text.endswith(('.', '!', '?')):
            return False
        if re.match(r'^[A-Z][A-Z\s\d\-_]+$', text):  # ALL CAPS
            return True
        if re.match(r'^\d+\.\d*\s+[A-Z]', text):  # Numbered section
            return True
        return False
    
    def is_code_like(self, text):
        """Determine if text looks like code"""
        code_indicators = ['()', '{', '}', '=>', 'function', 'class', 'def ', 'var ', 'let ', 'const ']
        return any(indicator in text for indicator in code_indicators)
    
    def convert_pdf(self, pdf_path, output_filename=None):
        """Convert a single PDF file to Markdown"""
        try:
            with open(pdf_path, 'rb') as file:
                pdf_reader = PyPDF2.PdfReader(file)
                
                if output_filename is None:
                    output_filename = Path(pdf_path).stem + '.md'
                
                output_path = Path(self.output_dir) / output_filename
                
                full_text = []
                
                print(f"Converting {pdf_path} ({len(pdf_reader.pages)} pages)...")
                
                for page_num, page in enumerate(pdf_reader.pages):
                    text = page.extract_text()
                    
                    if text.strip():
                        # Clean the text
                        cleaned_text = self.clean_text(text)
                        full_text.append(f"<!-- Page {page_num + 1} -->\n")
                        full_text.append(cleaned_text)
                        full_text.append("\n")
                
                # Combine all text
                combined_text = '\n'.join(full_text)
                
                # Format as Markdown
                markdown_content = self.format_as_markdown(combined_text)
                
                # Add header
                header = f"""# {Path(pdf_path).stem}

*Converted from PDF: {Path(pdf_path).name}*
*Conversion date: {Path().cwd()}*

---

"""
                
                final_content = header + markdown_content
                
                # Write to file
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(final_content)
                
                print(f"✓ Converted to: {output_path}")
                return output_path
            
        except Exception as e:
            print(f"✗ Error converting {pdf_path}: {str(e)}")
            return None
    
    def convert_multiple_pdfs(self, pdf_directory):
        """Convert all PDF files in a directory"""
        pdf_dir = Path(pdf_directory)
        if not pdf_dir.exists():
            print(f"Directory {pdf_directory} does not exist")
            return
        
        pdf_files = list(pdf_dir.glob("*.pdf"))
        if not pdf_files:
            print(f"No PDF files found in {pdf_directory}")
            return
        
        print(f"Found {len(pdf_files)} PDF files to convert...")
        
        successful_conversions = []
        failed_conversions = []
        
        for pdf_file in pdf_files:
            result = self.convert_pdf(pdf_file)
            if result:
                successful_conversions.append(result)
            else:
                failed_conversions.append(pdf_file)
        
        print(f"\n--- Conversion Summary ---")
        print(f"✓ Successfully converted: {len(successful_conversions)}")
        print(f"✗ Failed conversions: {len(failed_conversions)}")
        
        if successful_conversions:
            print(f"\nConverted files saved to: {self.output_dir}")
            for file in successful_conversions:
                print(f"  - {file.name}")


def main():
    parser = argparse.ArgumentParser(description="Convert PDF files to Markdown format")
    parser.add_argument("input", help="PDF file or directory containing PDF files")
    parser.add_argument("-o", "--output", help="Output filename (for single file conversion)")
    parser.add_argument("--output-dir", 
                       help="Output directory (default: research/pdf_conversions)")
    
    args = parser.parse_args()
    
    converter = PDFToMarkdownConverter()
    if args.output_dir:
        converter.output_dir = Path(args.output_dir)
    converter.setup_output_directory()
    
    input_path = Path(args.input)
    
    if input_path.is_file() and input_path.suffix.lower() == '.pdf':
        # Convert single file
        converter.convert_pdf(input_path, args.output)
    elif input_path.is_dir():
        # Convert all PDFs in directory
        converter.convert_multiple_pdfs(input_path)
    else:
        print(f"Error: {args.input} is not a valid PDF file or directory")
        sys.exit(1)


if __name__ == "__main__":
    main()