package com.boot.demo.service.impl;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.boot.demo.dao.IRoleDao;
import com.boot.demo.dao.support.IBaseDao;
import com.boot.demo.entity.Resource;
import com.boot.demo.entity.Role;
import com.boot.demo.service.IResourceService;
import com.boot.demo.service.IRoleService;
import com.boot.demo.service.support.impl.BaseServiceImpl;
import com.boot.demo.util.Constats;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;


/**
 * <p>
 * 角色表  服务实现类
 * </p>
 *
 * @since 2016-12-28
 */
@Service
public class RoleServiceImpl extends BaseServiceImpl<Role, Integer> implements IRoleService {
	@Autowired
	private IRoleDao roleDao;
	@Autowired
	private IResourceService resourceService;
	
	@Override
	public IBaseDao<Role, Integer> getBaseDao() {
		return this.roleDao;
	}

	@Override
	public void saveOrUpdate(Role role) {
		if(role.getId() != null){
			Role dbRole = find(role.getId());
			dbRole.setUpdateTime(new Date());
			dbRole.setName(role.getName());
			dbRole.setDescription(role.getDescription());
			dbRole.setUpdateTime(new Date());
			dbRole.setStatus(role.getStatus());
			update(dbRole);
		}else{
			role.setCreateTime(new Date());
			role.setUpdateTime(new Date());
			save(role);
		}
	}

	
	
	@Override
	public void delete(Integer id) {
		Role role = find(id);
		Assert.state(!"administrator".equals(role.getRoleKey()),"超级管理员角色不能删除");
		super.delete(id);
	}

	@Override
	public void grant(Integer id, String[] resourceIds) {
		Role role = find(id);
		Assert.notNull(role, "角色不存在");
		Resource resource;
		Set<Resource> resources = new HashSet<Resource>();
		if(resourceIds != null){
			for (int i = 0; i < resourceIds.length; i++) {
				if(StringUtils.isBlank(resourceIds[i]) || "0".equals(resourceIds[i])){
					continue;
				}
				Integer rid = Integer.parseInt(resourceIds[i]);
				resource = resourceService.find(rid);
				resources.add(resource);
			}
		}
		role.setResources(resources);
		update(role);
	}

	@Override
	public Page<Role> findAllByLike(String searchText, PageRequest pageRequest) {
		if(StringUtils.isBlank(searchText)){
			searchText = "";
		}
		return roleDao.findAllByNameContainingOrDescriptionContaining(searchText,searchText, pageRequest);
	}

	@Override
	public Integer getRoleNameCount(String name) {
		int count = roleDao.selectCountRoleName(name);
		return count;
	}

}
