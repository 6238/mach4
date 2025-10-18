# TODO

## YouTube Transcript Downloads

### Retry Failed Downloads (IP Blocked)
The following 10 videos from playlist PL7IitnI6IOQAUp6rOgtcQLwz7U8E4XHvq failed to download due to YouTube IP rate limiting. Retry these later (wait seve
al hours or use different IP):

1. `TMzAT0eb3p0` - https://www.youtube.com/watch?v=TMzAT0eb3p0
2. `QPHtXEufFwM` - https://www.youtube.com/watch?v=QPHtXEufFwM
3. `t2xQYvAXT8o` - https://www.youtube.com/watch?v=t2xQYvAXT8o
4. `_0WhzbFvoAM` - https://www.youtube.com/watch?v=_0WhzbFvoAM
5. `mZ7IAkK55pk` - https://www.youtube.com/watch?v=mZ7IAkK55pk
6. `wNPMqjkcJ_8` - https://www.youtube.com/watch?v=wNPMqjkcJ_8
7. `AthCnSaqV08` - https://www.youtube.com/watch?v=AthCnSaqV08
8. `eaYf73sQTDg` - https://www.youtube.com/watch?v=eaYf73sQTDg
9. `ry80BT3xGIo` - https://www.youtube.com/watch?v=ry80BT3xGIo
10. `ab6PXwBP62A` - https://www.youtube.com/watch?v=ab6PXwBP62A
11. `G85p1VsD3lk` - https://www.youtube.com/watch?v=G85p1VsD3lk

**Command to retry individually:**
```bash
source scripts/venv/bin/activate && python3 scripts/youtube_transcripts.py "VIDEO_URL"
```

# TODO - Mach4 Plugin Development

## 🔄 BLOCKED/WAITING

### YouTube Transcript Downloads (IP Rate Limited)
The following videos failed to download due to YouTube IP blocking. Retry when IP block is lifted:

**Failed Video IDs**: TMzAT0eb3p0, QPHtXEufFwM, t2xQYvAXT8o, _0WhzbFvoAM, mZ7IAkK55pk, wNPMqjkcJ_8, AthCnSaqV08, eaYf73sQTDg, ry80BT3xGIo, ab6PXwBP62A, G85p1VsD3lk

**Retry Command**:
```bash
source scripts/venv/bin/activate
for vid in TMzAT0eb3p0 QPHtXEufFwM t2xQYvAXT8o _0WhzbFvoAM mZ7IAkK55pk wNPMqjkcJ_8 AthCnSaqV08 eaYf73sQTDg ry80BT3xGIo ab6PXwBP62A G85p1VsD3lk; do
  python3 scripts/youtube_transcripts.py "https://www.youtube.com/watch?v=$vid"
  sleep 10  # Add delay between requests
done
```

