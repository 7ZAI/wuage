package com.wuage.entity.Vo;


import com.wuage.entity.Dept;
import com.wuage.entity.Menu;
import com.wuage.entity.Role;
import com.wuage.entity.User;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

/**
 * 给前端的用户信息
 */
@Data
public class SystemUserInfo {

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 登录名
     */
    private String loginName;

    /**
     * 密码
     */

    private String password;

    /**
     * 昵称
     */
    private String username;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 性别 1男 2女 3不确定
     */
    private Integer sex;


    /**
     * 电话
     */
    private String phone;

    /**
     * 创建时间
     */
    private LocalDateTime ctime;

    /**
     * 上次登录时间
     */
    private LocalDateTime lastLoginTime;

    private List<Role> roles;

    /**
     * 用户部门完整组织上级
     */
    private String  fullPathDeptName;

    /**
     * 菜单信息
     */
    private List<Menu> menus;


    public SystemUserInfo(User user) {
        Objects.requireNonNull(user);
        this.userId = user.getUserId();
        this.loginName = user.getLoginName();
        this.username = user.getUsername();
        this.avatar = user.getAvatar();
        this.sex = user.getSex();
        this.phone = user.getPhone();
        this.ctime = user.getCtime();
        this.lastLoginTime = user.getLastLoginTime();
    }
}
