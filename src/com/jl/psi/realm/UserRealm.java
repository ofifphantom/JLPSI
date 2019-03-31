package com.jl.psi.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.jl.psi.model.Person;
import com.jl.psi.service.PersonService;

public class UserRealm extends AuthorizingRealm{

	@Autowired
	private PersonService personService;
	
	/**
	 * 用户权限认证
	 * */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String loginName = (String)principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		Person person = personService.findUserByLoginName(loginName);
		//authorizationInfo.setStringPermissions(userService.findPermissions(user.getRoleId()));
		return authorizationInfo;
	}

	/**
	 * 用户登录信息验证
	 * */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String loginName = token.getPrincipal().toString();
		Person person = personService.findUserByLoginName(loginName);
		if(person == null){
			throw new UnknownAccountException();//没找到帐号
		}
		SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(loginName, person.getPassword(),getName());
		return authenticationInfo;
	}

}
