package com.boot.demo.controller.system;

import com.boot.demo.annotation.SysLog;
import com.boot.demo.controller.base.BaseController;
import com.boot.demo.entity.Resource;
import com.boot.demo.entity.base.Tree;
import com.boot.demo.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/resource")
public class ResourceController extends BaseController {

	@PostMapping("/tree/{roleId}")
	@ResponseBody
	public Tree<Resource> tree(@PathVariable Integer roleId){
		Tree<Resource> tree = new Tree<Resource>();
		tree = resourceService.tree(roleId);
		return tree;
	}
	
	@GetMapping("list")
	@SysLog("跳转菜单页面")
	public String list() {
		return "system/resource/list";
	}

	@RequiresPermissions("system:resource:list")
	@PostMapping("list")
	@ResponseBody
	public List<Resource>index() {
		List<Resource> resources = resourceService.findAll();
		return resources;
	}

    @GetMapping("/font")
    public String font() {
        return "public/FontIcoList";
    }
	
	@GetMapping(value = "/add/{id}")
	public String add(@PathVariable Integer id,ModelMap map) {
		if(id != 0){
			Resource resource = resourceService.find(id);
			map.put("pid",resource.getId());
			map.put("pName",resource.getName());
		} else {
			map.put("pid", 0);
		}
		return "system/resource/add";
	}

	@GetMapping("/edit/{id}")
	public String edit(@PathVariable Integer id,ModelMap map) {
		Resource resource = resourceService.find(id);
		map.put("resource", resource);
		List<Resource> list = resourceService.findAll();
		map.put("list", list);
		return "system/resource/edit";
	}

	@RequiresPermissions("system:resource:add")
	@PostMapping("/addSave")
	@ResponseBody
	@SysLog("保存新增菜单数据")
	public RestResponse addSave(Resource resource) {
		if (resourceService.getCountByName(resource.getName()) > 0) {
			return RestResponse.failure("菜单名称已存在");
		}
		 if(resource.getPid()==null){
			resource.setPid(0);
		 }
            resource.setIsHide(0);
		    resourceService.saveOrUpdate(resource);
		    return RestResponse.success("提交成功");
	}

	@RequiresPermissions("system:resource:edit")
	@PostMapping("/editSave")
	@ResponseBody
	@SysLog("保存编辑菜单数据")
	public RestResponse editSave(Resource resource){
        Resource oldresource = resourceService.find(resource.getId());
        if (StringUtils.isNotBlank(resource.getName())) {
            if (!oldresource.getName().equals(resource.getName())) {
                if (resourceService.getCountByName(resource.getName()) > 0) {
                    return RestResponse.failure("菜单名称已存在");
                }
            }
        }

        if(resource.getSort() == null){
            return RestResponse.failure("排序值不能为空");
        }
        resourceService.saveOrUpdate(resource);
		return RestResponse.success("更新成功");
	}


	@RequiresPermissions("system:resource:delete")
	@PostMapping( "/delete/{id}")
	@ResponseBody
	@SysLog("删除菜单")
	public RestResponse delete(@PathVariable Integer id) {
		if(id == null){
			return RestResponse.failure("菜单ID不能为空");
		}
		resourceService.delete(id);
		return RestResponse.success("删除菜单成功");
	}
}
