package com.wuage.utils.img;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * 图片转化Ascii
 */
public class AsciiPic {

    /*
     * 将image转换成bufferimage
     */
    public static BufferedImage toBufferedImage(Image image) {
        if (image instanceof BufferedImage) {
            return (BufferedImage)image;
        }

        // 加载所有像素
        image = new ImageIcon(image).getImage();
        BufferedImage bimage = null;
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        try {
            int transparency = Transparency.OPAQUE;

            // 创建buffer图像
            GraphicsDevice gs = ge.getDefaultScreenDevice();
            GraphicsConfiguration gc = gs.getDefaultConfiguration();
            bimage = gc.createCompatibleImage(image.getWidth(null), image.getHeight(null), transparency);
        } catch (HeadlessException e) {
            e.printStackTrace();
        }
        if (bimage == null) {
            int type = BufferedImage.TYPE_INT_RGB;
            bimage = new BufferedImage(image.getWidth(null), image.getHeight(null), type);
        }
        // 复制
        Graphics g = bimage.createGraphics();
        // 赋值
        g.drawImage(image, 0, 0, null);
        g.dispose();
        return bimage;
    }

    public static Image creatImage(String Imgpath) {
        Image srcImg = null;
        try {
            srcImg = ImageIO.read(new FileInputStream(Imgpath));
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
        } catch (IOException e1) {
            e1.printStackTrace();
        }
        //取源图
        int width = 50; //假设要缩小到200点像素
        int height = srcImg.getHeight(null)*200/srcImg.getWidth(null);//按比例，将高度缩减
        Image smallImg =srcImg.getScaledInstance(width, height, Image.SCALE_SMOOTH);//缩小
        return smallImg;
    }

    /**
     * @param bfimage  图片路径
     */
    public static void createAsciiPic(BufferedImage bfimage) throws IOException {
        final String base = "@#&$%*o!;.";// 字符串由复杂到简单
        final BufferedImage image = bfimage;
        for (int y = 0; y < image.getHeight(); y += 2) {
            for (int x = 0; x < image.getWidth(); x++) {
                final int pixel = image.getRGB(x, y);
                final int r = (pixel & 0xff0000) >> 16, g = (pixel & 0xff00) >> 8, b = pixel & 0xff;
                final float gray = 0.299f * r + 0.578f * g + 0.114f * b;
                final int index = Math.round(gray * (base.length() + 1) / 255);
                System.out.print(index >= base.length() ? " " : String.valueOf(base.charAt(index)));
            }
            System.out.println();
        }
    }

    public static void main(final String[] args) {
        try {
            AsciiPic.createAsciiPic(toBufferedImage(creatImage("C:\\Users\\Administrator\\Pictures\\m.jpg")));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}