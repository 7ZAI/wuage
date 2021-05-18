package com.wuage.controller;


import com.google.code.kaptcha.Producer;
import com.wuage.constant.UserConstant;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;

/**
 * 验证码
 */
@Controller
public class CaptchaController extends BaseController {

    @Resource(name = "captchaProducer")
    private Producer captchaProducer;


    @GetMapping("/captchaImage")
    public void getCaptchaImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ServletOutputStream sos = null;
        try {
            Session session = SecurityUtils.getSubject().getSession();
//            System.out.println("session2" + session2.getId());
            //设置缓存控制 可以设置Pragma 或Cache-Control 这里设置为不缓存
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache"); // Pragma 已逐渐废弃 这里是为了兼容

            response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            response.addHeader("Cache-Control", "post-check=0, pre-check=0");
            response.setContentType("image/jpeg");

            String code = captchaProducer.createText();

            session.setAttribute(UserConstant.CAPTCHA_KEY, code);

            BufferedImage codeImage = captchaProducer.createImage(code);
            sos = response.getOutputStream();
            ImageIO.write(codeImage, "jpg", sos);
            sos.flush();

        } catch (Exception e) {
            logger.error(e.getMessage());
           throw  e;
        } finally {
            if (sos != null) {
                sos.close();
            }

        }
    }
}
