package com.boot.demo.dao;

import com.boot.demo.dao.support.IBaseDao;
import com.boot.demo.entity.Resource;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IResourceDao extends IBaseDao<Resource, Integer> {
       List<Resource> findAllByOrderByPidAscIdAscSortAsc();
	@Modifying
	@Query(nativeQuery = true,value = "DELETE FROM tb_role_resource WHERE resource_id = :id")
	void deleteGrant(@Param("id") Integer id);
	Page<Resource> findAllByNameContaining(String searchText, Pageable pageable);

    	@Query(nativeQuery = true,value = "SELECT distinct m.*\n" +
                "FROM tb_resource m\n" +
                "LEFT JOIN tb_role_resource rm on rm.resource_id = m.id\n" +
                "LEFT JOIN tb_role r on r.id = rm.role_id\n" +
                "LEFT JOIN tb_user_role ur on ur.role_id = r.id\n" +
                "LEFT JOIN tb_user u on u.id = ur.user_id\n" +
                "WHERE u.id =:id and  m.type in(0,1)\n" +
                "order by m.sort desc")
        List<Resource> selectShowMenuByUser(@Param("id") Integer id);


    @Query(nativeQuery = true,value = "select resource_id from tb_role_resource where role_id =:roleId")
    List<Integer> listMenuByRoleId(@Param("roleId") Integer roleId);

    @Query(value = "select count(*) from tb_resource where name=:name",nativeQuery = true)
    int getCountByName(@Param("name") String name);



}
