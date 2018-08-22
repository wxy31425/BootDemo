package com.boot.demo.controller;

import com.boot.demo.annotation.SysLog;
import com.boot.demo.controller.base.BaseController;
import com.boot.demo.entity.Resource;
import com.boot.demo.entity.User;
import com.boot.demo.entity.base.Tree;
import com.boot.demo.util.RestResponse;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.apache.shiro.subject.Subject;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;
import java.util.List;

@Controller
public class LoginController extends BaseController {

	@GetMapping("login")
	public String login() {
		return "login";
	}

	@PostMapping("admin/login")
	@ResponseBody
	@SysLog("用户登录")
	public RestResponse loginMain(HttpServletRequest request) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
			return RestResponse.failure("用户名或者密码不能为空");
		}
		Map<String, Object> map = Maps.newHashMap();
		String error = null;
		HttpSession session = request.getSession();
		if (session == null) {
			return RestResponse.failure("session超时");
		} else {
			/*就是代表当前的用户。*/
			Subject user = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			try {
				user.login(token);
				if (user.isAuthenticated()) {
					map.put("url", "index");
				}
			} catch (IncorrectCredentialsException e) {
				error = "登录密码错误.";
			} catch (LockedAccountException e) {
				error = "帐号已被锁定.";
			} catch (UnknownAccountException e) {
				error = "帐号不存在";
			}
		}
		if (StringUtils.isBlank(error)) {
			return RestResponse.success("登录成功").setData(map);
		} else {
			return RestResponse.failure(error);
		}
	}

	@GetMapping("index")
	public String showView(ModelMap model) {
		User user = (User) SecurityUtils.getSubject().getPrincipal();
		int userId = user.getId();
		List<Tree<Resource>> menus = resourceService.listMenuTree(userId);
		model.put("menus", menus);
		return "index";
	}


	@GetMapping("/admin/logout")
	public String logout() {
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return redirect("admin/login");
	}
}
	

