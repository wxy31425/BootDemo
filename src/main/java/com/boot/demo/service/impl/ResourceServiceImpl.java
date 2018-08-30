package com.boot.demo.service.impl;

import java.util.*;

import com.boot.demo.dao.IResourceDao;
import com.boot.demo.dao.support.IBaseDao;
import com.boot.demo.entity.Resource;
import com.boot.demo.entity.base.Tree;
import com.boot.demo.service.IResourceService;
import com.boot.demo.service.IRoleService;
import com.boot.demo.service.support.impl.BaseServiceImpl;
import com.boot.demo.util.BuildTree;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;


/**
 * <p>
 * 资源表 服务实现类
 * </p>
 *
 * @since 2016-12-28
 */
@Service
public class ResourceServiceImpl extends BaseServiceImpl<Resource, Integer> implements IResourceService {
	@Autowired
	private IResourceDao resourceDao;

	@Override
	public IBaseDao<Resource, Integer> getBaseDao() {
		return this.resourceDao;
	}

	@Override
	public Tree<Resource> tree(int roleId) {
		List<Resource> roleResources = resourceDao.findAll();
		List<Integer> resourceIds = resourceDao.listMenuByRoleId(roleId);
		List<Integer> temp = resourceIds;
		for (Resource resource : roleResources) {
			if (temp.contains(resource.getPid())) {
				temp.remove(resource.getPid());
			}
		}
		List<Tree<Resource>> trees = new ArrayList<Tree<Resource>>();
		for (Resource menuu : roleResources) {
			Tree<Resource> tree = new Tree<Resource>();
			tree.setId(menuu.getId().toString());
			tree.setParentId(menuu.getPid().toString());
			tree.setText(menuu.getName());
			Map<String, Object> state = new HashMap<>(16);
			Integer menuId = menuu.getId();
			if (resourceIds.contains(menuId)) {
				state.put("selected", true);
			} else {
				state.put("selected", false);
			}
			tree.setState(state);
			trees.add(tree);
		}
		// 默认顶级菜单为０，根据数据库实际情况调整
		Tree<Resource> t = BuildTree.build(trees);
		return t;
	}

	@Override
	public void saveOrUpdate(Resource resource) {
		if (resource.getId() != null) {
			Resource dbResource = find(resource.getId());
			dbResource.setUpdateTime(new Date());
			dbResource.setName(resource.getName());
			dbResource.setSourceKey(resource.getSourceKey());
			dbResource.setType(resource.getType());
			dbResource.setUrl(resource.getUrl());
			dbResource.setLevel(resource.getLevel());
			dbResource.setSort(resource.getSort());
			dbResource.setIsHide(resource.getIsHide());
			dbResource.setIcon(resource.getIcon());
			dbResource.setDescription(resource.getDescription());
			dbResource.setUpdateTime(new Date());
			update(dbResource);
		} else {
			resource.setCreateTime(new Date());
			resource.setUpdateTime(new Date());
			save(resource);
		}
	}

	@Override
	public void delete(Integer id) {
		resourceDao.deleteGrant(id);
		super.delete(id);
	}

	@Override
	public Page<Resource> findAllByLike(String searchText, PageRequest pageRequest) {
		if (StringUtils.isBlank(searchText)) {
			searchText = "";
		}
		return resourceDao.findAllByNameContaining(searchText, pageRequest);
	}

	@Override
	public List<Tree<Resource>> listMenuTree(int id) {
		List<Tree<Resource>> trees = new ArrayList<Tree<Resource>>();
		List<Resource> menus = resourceDao.selectShowMenuByUser(id);
		for (Resource resource : menus) {
			Tree<Resource> tree = new Tree<Resource>();
			tree.setId(resource.getId().toString());
			tree.setParentId(resource.getPid().toString());
			tree.setText(resource.getName());
			tree.setPerm(resource.getSourceKey());
			Map<String, Object> attributes = new HashMap<>(16);
			attributes.put("url", resource.getUrl());
			attributes.put("icon", resource.getIcon());
			attributes.put("isHide",resource.getIsHide());
			tree.setAttributes(attributes);
			trees.add(tree);
		}
		// 默认顶级菜单为０，根据数据库实际情况调整
		List<Tree<Resource>> list = BuildTree.buildList(trees, "0");
		return list;
	}

	@Override
	public int getCountByName(String name) {
		int count = resourceDao.getCountByName(name);
		return count;
	}



}
