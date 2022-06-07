import os
import importlib
import PIL.Image
import PIL.ImageDraw


def create_font_sample(font, px_size, px_space):
    r = 0
    c = 0
    bitmaps = []
    rbitmaps = []
    for ch, glyph in font.glyphs():
        rbitmaps.append((ch, glyph))
        c += 1
        if c == 16:
            if len(rbitmaps):
                bitmaps.append(rbitmaps)
            rbitmaps = []
            r += 1
            c = 0

    if len(rbitmaps):
        bitmaps.append(rbitmaps)

    rows = len(bitmaps)
    im = PIL.Image.new('1', (16 * (font.max_width()+px_space[0]) * px_size[0], rows * (font.height()+px_space[1]) * px_size[1]), 1)
    draw = PIL.ImageDraw.Draw(im)

    for r in range(len(bitmaps)):
        rbitmaps = bitmaps[r]
        for c, (ch, (ch_bitmap, ch_height, ch_width)) in enumerate(rbitmaps):
#            print(r, c, ccode, hex(ccode), chr(ccode))

            o = ''
            ch_x_offset = c * (font.max_width()+px_space[0]) + int(px_space[0]/2)
            ch_y_offset = r * (font.height()+px_space[1]) + int(px_space[1]/2)
            for y in range(ch_height):
                for x in range(ch_width):
                    bmp_byten, bmp_bitn = divmod(y, 8)
                    bmp_byten += x * (((ch_height-1) // 8)+1)
                    bmp_byte = ch_bitmap[bmp_byten]
                    bmp_bit = (bmp_byte >> bmp_bitn) & 0x01
                    pxl = not bmp_bit
                    txl = '#' if bmp_bit else '.'
#                    print(bmp_byten, bmp_bitn, txl)
                    o += txl
                    
                    px_x = ch_x_offset + x
                    px_y = ch_y_offset + y
                    draw.rectangle([(px_x*px_size[0], px_y*px_size[1]), (px_x*px_size[0], px_y*px_size[1])], pxl, pxl, 0)
#                print()
                o += '\n'
#            print(o)
            ch_x_offset += ch_width + px_space[0]

    
    return im


if __name__ == '__main__':
    import sys
    
    pyf_fn = sys.argv[1]
    out_fn = sys.argv[2]
    
    pyf_mn = os.path.splitext(pyf_fn)[0].replace('/', '.')
    pyf_m = importlib.import_module(pyf_mn)
    
    im = create_font_sample(pyf_m, (1, 1), (4, 4))
    im.save(out_fn)
