package com.wuage.controller;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.wuage.Result.ApiResult;
import com.wuage.annotation.RepeatSubmit;
import com.wuage.entity.User;
import com.wuage.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.constraints.NotNull;

@RestController
@Validated
@RequestMapping("/system")
public class SysProfileController  extends BaseController  {

    @Autowired
    private UserService userService;

    @RepeatSubmit
    @PutMapping("/profile")
    public ApiResult modifyProfile(@NotNull String phone, @NotNull String name, String remark) throws Exception{

        User user = (User) SecurityUtils.getSubject().getPrincipal();

        userService.update(new UpdateWrapper<User>().lambda().eq(User::getUserId, user.getUserId())
                .set(User::getUsername,name)
                .set(User::getRemark,remark)
                .set(User::getPhone,phone));

        return ApiResult.success();
    }


    @RepeatSubmit
    @PutMapping("/profile/password")
    public ApiResult modifyPwd(@NotNull String oldpwd, @NotNull String newpwd,  @NotNull String checkpwd) throws Exception{

        User user = (User) SecurityUtils.getSubject().getPrincipal();


        if(!newpwd.equals(checkpwd)){
            return ApiResult.fail("两次输入的新密码不一致！");
        }

        user = userService.getById(user.getUserId());

        ByteSource bytesalt = new Md5Hash(user.getSalt()+ user.getLoginName());
        SimpleHash simpleHash = new SimpleHash("md5", oldpwd, bytesalt, 2);

        if(simpleHash.toHex().equals(user.getPassword())){

            SimpleHash newsimpleHash = new SimpleHash("md5", newpwd, bytesalt, 2);
            userService.update(new UpdateWrapper<User>().lambda()
                    .eq(User::getUserId, user.getUserId()).set(User::getPassword, newsimpleHash.toHex()));

            return ApiResult.success();
        }

        return ApiResult.fail("旧密码错误！");
    }

}
