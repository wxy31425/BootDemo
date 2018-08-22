package com.boot.demo.config.shiro;

import java.util.HashSet;
import java.util.Set;

import com.boot.demo.entity.Resource;
import com.boot.demo.entity.Role;
import com.boot.demo.entity.User;
import com.boot.demo.service.IUserService;
import com.boot.demo.util.MD5Utils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.AllowAllCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component(value = "myRealm")
public class MyRealm extends AuthorizingRealm {
	public MyRealm(){
		super(new AllowAllCredentialsMatcher());
        setAuthenticationTokenClass(UsernamePasswordToken.class);
        //FIXME: 暂时禁用Cache
        setCachingEnabled(false);
	}
	@Autowired
	private IUserService userService;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		User user = (User) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		User dbUser = userService.findByUserName(user.getUserName());
		Set<String> shiroPermissions = new HashSet<>();
		Set<String> roleSet = new HashSet<String>();
		Set<Role> roles = dbUser.getRoles();
		for (Role role : roles) {
			Set<Resource> resources = role.getResources();
			for (Resource resource : resources) {
				shiroPermissions.add(resource.getSourceKey());
				
			}
			roleSet.add(role.getRoleKey());
		}
		authorizationInfo.setRoles(roleSet);
		authorizationInfo.setStringPermissions(shiroPermissions);
		return authorizationInfo;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username = (String) token.getPrincipal();
		User user = userService.findByUserName(username);
		String password = new String((char[]) token.getCredentials());
		// 账号不存在
		if (user == null) {
			throw new UnknownAccountException();
		}
		// 密码错误
		String pwd = MD5Utils.md5(password);
		if (!pwd.equals(user.getPassword())) {
			throw new IncorrectCredentialsException();
		}
		// 账号锁定
		if (user.getLocked() == 1) {
			throw new LockedAccountException();
		}
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, password, getName());
		return info;
	}

}
