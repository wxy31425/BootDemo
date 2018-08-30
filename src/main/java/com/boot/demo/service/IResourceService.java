package com.boot.demo.service;

import java.util.List;

import com.boot.demo.entity.Resource;
import com.boot.demo.entity.base.Tree;
import com.boot.demo.service.support.IBaseService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * <p>
 * 资源服务类
 * </p>
 *
 * @since 2016-12-28
 */
public interface IResourceService extends IBaseService<Resource, Integer> {
	/**
	 * 获取角色的权限树
	 *
	 * @param roleId
	 * @return
	 */
	Tree<Resource> tree(int roleId);

	/**
	 * 修改或者新增资源
	 *
	 * @param resource
	 */
	void saveOrUpdate(Resource resource);

	/**
	 * 关键字分页
	 *
	 * @param searchText
	 * @param pageRequest
	 * @return
	 */
	Page<Resource> findAllByLike(String searchText, PageRequest pageRequest);

	/**
	 * 树型菜单列表
	 */
	List<Tree<Resource>> listMenuTree(int id);

	/**
	 * 菜单检查
	 */
	int getCountByName(String name);

}
