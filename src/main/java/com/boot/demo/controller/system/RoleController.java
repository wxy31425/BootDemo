package com.boot.demo.controller.system;

import com.boot.demo.annotation.SysLog;
import com.boot.demo.controller.base.BaseController;
import com.boot.demo.entity.Role;
import com.boot.demo.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/role")
public class RoleController extends BaseController {


	@GetMapping("list")
	@SysLog("跳转角色列表页面")
	public String list() {
		return "system/role/list";
	}

	@RequiresPermissions("system:role:list")
	@PostMapping("list")
	@ResponseBody
	public Page<Role> list(@RequestParam(value="searchText",required=false) String searchText) {
		Page<Role> page = roleService.findAllByLike(searchText, getPageRequest());
		return page;
	}
	
	@GetMapping("/add")
	public String add() {
		return "system/role/add";
	}

    @GetMapping( "/edit/{id}")
    public String edit(@PathVariable Integer id,ModelMap model) {
        Role role = roleService.find(id);
        model.put("role", role);
        return "system/role/edit";
    }

	@RequiresPermissions("system:role:add")
	@PostMapping("/addSave")
	@ResponseBody
	@SysLog("保存新增角色数据")
	public RestResponse addSave(Role role){
		if(roleService.getRoleNameCount(role.getName())>0){
			return RestResponse.failure("角色名称已存在");
		}
		role.setStatus(0);
		roleService.saveOrUpdate(role);
		return RestResponse.success("添加成功");
	}

	@RequiresPermissions("system:role:edit")
	@PostMapping("/editSave")
	@ResponseBody
	@SysLog("保存编辑角色数据")
	public RestResponse editSave(Role role){
		Role oldRole = roleService.find(role.getId());
		if(StringUtils.isNotBlank(role.getName())) {
			if (!oldRole.getName().equals(role.getName())) {
				if (roleService.getRoleNameCount(role.getName()) > 0) {
					return RestResponse.failure("角色名称已存在");
				}
			}
		}
		roleService.saveOrUpdate(role);
		return RestResponse.success("更新成功");
	}


	@GetMapping("/grant/{id}")
	public String grant(@PathVariable Integer id, ModelMap map) {
		Role role = roleService.find(id);
		map.put("role", role);
		return "system/role/grant";
	}

	@RequiresPermissions("system:role:grant")
	@PostMapping("/grantSave/{id}")
	@ResponseBody
	@SysLog("分配角色数据")
	public RestResponse grantSave(@PathVariable Integer id, String[] resourceIds) {
			roleService.grant(id,resourceIds);
		    return RestResponse.success("分配成功");
	}

	@RequiresPermissions("system:role:delete")
	@PostMapping(value = "/delete/{id}")
	@ResponseBody
	@SysLog("删除角色数据(单个)")
	public RestResponse delete(@PathVariable Integer id) {
		if(id == null || id == 0){
			return RestResponse.failure("角色ID不能为空");
		}
		   roleService.delete(id);
		return RestResponse.success("删除成功");
	}

	@RequiresPermissions("system:role:deleteBatch")
	@ResponseBody
	@PostMapping("/batchRemove")
	@SysLog("删除角色数据(批量)")
	public RestResponse batchRemove(@RequestParam("ids[]") Integer[] ids) {
		for(Integer id :ids){
			if(id == null || id == 0){
				return RestResponse.failure("角色不存在");
			}
			roleService.delete(id);
		}
		return RestResponse.success("删除成功");
	}

}
