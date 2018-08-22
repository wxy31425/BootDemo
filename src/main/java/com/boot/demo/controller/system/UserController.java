package com.boot.demo.controller.system;


import com.boot.demo.annotation.SysLog;
import com.boot.demo.controller.base.BaseController;
import com.boot.demo.entity.Role;
import com.boot.demo.entity.User;
import com.boot.demo.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/admin/user")
public class UserController extends BaseController {


	@GetMapping("list")
	@SysLog(" 跳转系统用户页面")
	public String list (){
		return "system/admin/list";
	}


	@RequiresPermissions("system:user:list")
	@PostMapping("list")
	@ResponseBody
	public Page<User> list(@RequestParam(value="searchText",required=false) String searchText) {
		Page<User> page = userService.findAllByLike(searchText, getPageRequest());
		return page;
	}

	@GetMapping("/add")
	public String add(ModelMap model) {
		List<Role> roles = roleService.findAll();
		model.put("roles", roles);
		return "system/admin/add";
	}

	@GetMapping(value = "/edit/{id}")
	public String edit(@PathVariable Integer id,ModelMap map) {
		User user = userService.find(id);
		map.put("user", user);
		Set<Role> set = user.getRoles();
		List<Integer> roleIds = new ArrayList<Integer>();
		for (Role role : set) {
			roleIds.add(role.getId());
		}
		map.put("roleIds", roleIds);
		List<Role> roles = roleService.findAll();
		map.put("roles", roles);
		return "system/admin/edit";
	}

	@RequiresPermissions("system:user:add")
	@PostMapping("/addSave")
	@ResponseBody
	@SysLog("保存新增系统用户数据")
	public RestResponse addSave(User user,String[] roleIds){
		if(userService.userCountUserName(user.getUserName())>0){
			return RestResponse.failure("登录名称已经存在");
		}
		if(StringUtils.isNotBlank(user.getEmail())){
			if(userService.userCountEmail(user.getEmail())>0){
				return RestResponse.failure("该邮箱已被使用");
			}
		}
		if(StringUtils.isNoneBlank(user.getTelephone())){
			if(userService.userCountTelephone(user.getTelephone())>0){
				return RestResponse.failure("该手机号已被绑定");
			}
		}
		    user.setLocked(0);
			userService.saveOrUpdate(user);
		if(user.getId() == null || user.getId() == 0){
			return RestResponse.failure("保存用户信息出错");
		}
			int id = user.getId();
			userService.grant(id,roleIds);
			return RestResponse.success("添加成功");
	}

	@RequiresPermissions("system:user:edit")
	@PostMapping("/editSave")
	@ResponseBody
	@SysLog("保存系统用户编辑数据")
	public RestResponse editSave(User user,String[] roleIds){
		User oldUser = userService.find(user.getId());
        if(StringUtils.isNotBlank(user.getEmail())){
			if(!user.getEmail().equals(oldUser.getEmail())){
                if(userService.userCountEmail(user.getEmail())>0) {
					return RestResponse.failure("该邮箱已被使用");
				}
            }
        }
        if(StringUtils.isNoneBlank(user.getTelephone())) {
			if (!user.getTelephone().equals(oldUser.getTelephone())) {
				if (userService.userCountTelephone(user.getTelephone()) > 0) {
					return RestResponse.failure("该手机号已被绑定");
				}
			}
		}
		userService.saveOrUpdate(user);
		if(user.getId() == null || user.getId() == 0){
			return RestResponse.failure("保存用户信息出错");
		}
		int id = user.getId();
		userService.grant(id,roleIds);
		return RestResponse.success("更新成功");
	}

	@RequiresPermissions("system:user:delete")
	@PostMapping("/delete/{id}")
	@ResponseBody
	@SysLog("删除系统用户数据(单个)")
	public RestResponse delete(@PathVariable Integer id) {
        if(id == null || id == 0){
            return RestResponse.failure("用户不存在");
        }
        userService.delete(id);
		return RestResponse.success("删除成功");
	}

	@RequiresPermissions("system:user:deleteBatch")
	@ResponseBody
	@PostMapping("/batchRemove")
	@SysLog("删除系统用户数据(批量)")
	public RestResponse batchRemove(@RequestParam("ids[]") Integer[] ids) {
		for(Integer id :ids){
			if(id == null || id == 0){
				return RestResponse.failure("用户不存在");
			}
			userService.delete(id);
		}
		return RestResponse.success("删除成功");
	}
//
//	@RequestMapping(value = "/grant/{id}", method = RequestMethod.GET)
//	public String grant(@PathVariable Integer id, ModelMap map) {
//		User user = userService.find(id);
//		map.put("user", user);
//
//		Set<Role> set = user.getRoles();
//		List<Integer> roleIds = new ArrayList<Integer>();
//		for (Role role : set) {
//			roleIds.add(role.getId());
//		}
//		map.put("roleIds", roleIds);
//
//		List<Role> roles = roleService.findAll();
//		map.put("roles", roles);
//		return "admin/user/grant";
//	}
//
//	@ResponseBody
//	@RequestMapping(value = "/grant/{id}", method = RequestMethod.POST)
//	public JsonResult grant(@PathVariable Integer id,String[] roleIds, ModelMap map) {
//		try {
//			userService.grant(id,roleIds);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return JsonResult.failure(e.getMessage());
//		}
//		return JsonResult.success();
//	}
//

	@GetMapping("updatePwd")
	public String updatePwd() {
		return "system/admin/pwd";
	}

	@RequiresPermissions("system:user:changePassword")
	@PostMapping("/updatePwd")
	@ResponseBody
	@SysLog("修改密码)")
	public RestResponse updatePwd(String oldPassword, String password1, String password2) {
		try {
		   Subject subject = SecurityUtils.getSubject();
			Object principal = subject.getPrincipal();
			if(principal== null){
				return RestResponse.failure("您尚未登录");
			}
			userService.updatePwd((User)principal, oldPassword, password1, password2);
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.failure(e.getMessage());
		}
		return RestResponse.success("修改成功");
	}
}
