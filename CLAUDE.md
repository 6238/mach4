# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project is for creating a plugin to develop user interface widgets for the Mach4 software, which is used with CNC machines. Specifically targeting the Avid Benchtop Pro CNC machine.

**Key Project Goals:**
- Create custom UI widgets for Mach4 CNC control software
- Target Avid Benchtop Pro CNC machine integration
- Research underdocumented Mach4 plugin development process
- Develop practical solutions for CNC machine operation

## Current Structure

- `research/` - Directory for Mach4 plugin development research and documentation

## Helper Scripts

**Preference: Use Python for helper scripts to support research activities.**

When creating utility scripts for data processing, analysis, or research automation, prefer Python for its rich ecosystem of scientific and data analysis libraries.

### Python Package Management

**Best Practice 2025: Use virtual environments for all Python projects**

Following modern Python development practices, this project uses local virtual environments to isolate dependencies:

#### Setup Instructions:
1. **Create virtual environment:** `python3 -m venv scripts/venv`
2. **Activate environment:** `source scripts/venv/bin/activate` (macOS/Linux) or `scripts\venv\Scripts\activate` (Windows)
3. **Install packages:** `pip install package_name`
4. **Save dependencies:** `pip freeze > scripts/requirements.txt`
5. **Install from requirements:** `pip install -r scripts/requirements.txt`

#### Running Scripts:
- Always activate the virtual environment before running scripts
- Example: `source scripts/venv/bin/activate && python3 scripts/fetch_forum_thread.py`

#### Current Dependencies:
- `requests` - HTTP client for web scraping
- `beautifulsoup4` - HTML parsing for forum content extraction
- `youtube-transcript-api` - YouTube transcript extraction
- `yt-dlp` - Video metadata extraction
- `PyMuPDF` - PDF text extraction and processing

The virtual environment is located at `scripts/venv/` and should not be committed to version control.

### YouTube Transcript Downloader

**Script:** `scripts/youtube_transcripts.py`

A utility for downloading YouTube video transcripts and metadata to support Mach4 research. The script extracts comprehensive video information and saves transcripts as markdown files.

#### Features:
- Downloads transcripts from YouTube videos
- Extracts video metadata (title, channel, upload date, duration, view count)
- Saves as organized markdown files with proper naming
- Handles videos without transcripts gracefully

#### Usage:
```bash
# Activate virtual environment
source scripts/venv/bin/activate

# Download a single video transcript
python3 scripts/youtube_transcripts.py "https://www.youtube.com/watch?v=VIDEO_ID"

# Specify custom output directory (optional)
python3 scripts/youtube_transcripts.py "https://www.youtube.com/watch?v=VIDEO_ID" --output-dir custom/path
```

#### Preferred Workflow:
1. **Default Output:** Transcripts are automatically saved to `research/transcripts/`
2. **Filename Format:** Uses actual video title (e.g., `Mach4_and_Arduino_Leonardo.md`)
3. **Organization:** Keep all YouTube research transcripts in the `research/transcripts/` directory
4. **Metadata:** Each transcript includes comprehensive video information and download timestamp

#### Example Output Structure:
```
research/
├── transcripts/
│   ├── Mach4_and_Arduino_Leonardo.md
│   ├── CNC_Router_Setup_Guide.md
│   └── Avid_Benchtop_Pro_Review.md
```

#### Requirements:
- Virtual environment must be activated
- Dependencies installed: `pip install -r scripts/requirements.txt`
- Internet connection for video metadata and transcript access

### PDF to Markdown Converter

**Script:** `scripts/pdf_to_markdown.py`

A utility for converting PDF files to Markdown format, specifically designed for processing Mach4 API documentation and technical manuals.

#### Features:
- Converts PDF files (100-200+ pages) to well-structured Markdown
- Preserves document structure (headings, code blocks, lists)
- Cleans common OCR artifacts and formatting issues
- Batch processing for multiple PDF files
- Page markers for easy reference to source material

#### Usage:
```bash
# Activate virtual environment
source scripts/venv/bin/activate

# Convert a single PDF file
python3 scripts/pdf_to_markdown.py path/to/document.pdf

# Convert all PDFs in a directory
python3 scripts/pdf_to_markdown.py path/to/pdf/directory/

# Specify custom output filename for single file
python3 scripts/pdf_to_markdown.py document.pdf -o custom_name.md

# Use custom output directory
python3 scripts/pdf_to_markdown.py document.pdf --output-dir custom/path
```

#### Preferred Workflow:
1. **Default Output:** Converted files are saved to `research/pdf_conversions/`
2. **Filename Format:** Uses PDF filename with `.md` extension
3. **Organization:** Keep all PDF conversions in the `research/pdf_conversions/` directory
4. **Structure:** Each markdown file includes page markers and preserves original formatting

#### Example Output Structure:
```
research/
├── pdf_conversions/
│   ├── Mach4_API_Reference.md
│   ├── Plugin_Development_Guide.md
│   └── CNC_Interface_Documentation.md
```

#### Requirements:
- Virtual environment must be activated
- Dependencies installed: `pip install -r scripts/requirements.txt`
- PDF files must be text-based (not scanned images)

## Development Context

**Important Notes:**
- Mach4 plugin development is underdocumented
- Research phase is critical before implementation
- Focus on UI widget creation for CNC control interfaces
- Target hardware: Avid Benchtop Pro CNC machine

## Development Workflow

1. **Research Phase** - Gather information on Mach4 plugin development
2. **Planning Phase** - Create development plan based on research findings  
3. **Implementation Phase** - Build UI widgets and plugins
4. **Testing Phase** - Test with Avid Benchtop Pro CNC setup

This CLAUDE.md file should be updated as research reveals the actual Mach4 development requirements and toolchain.

## Testing Requirements

**CRITICAL: Always run tests after making changes to code**

After any modification to Lua macros, utilities, or core functionality:

1. **Run the test suite immediately:**
   ```bash
   cd src/tests
   lua test_runner.lua
   ```

2. **Verify all tests pass** before considering the change complete

3. **Update tests** if functionality changes require new test expectations

4. **Add new tests** for any new features or macros created

The test suite validates:
- Macro functionality and G-code execution
- Mock API compatibility 
- UI functionality
- Error handling and edge cases

**Test failures must be resolved before proceeding with additional development.**

## G-code Execution Architecture

When writing code related to Gcode, be sure to all of GCODE_EXECUTION_BEST_PRACTICES.md and follow the instruction in that file.
