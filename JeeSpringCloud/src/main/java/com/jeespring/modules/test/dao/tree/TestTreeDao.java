/**
 * * Copyright &copy; 2015-2020 <a href="https://gitee.com/JeeHuangBingGui/JeeSpring">JeeSpring</a> All rights reserved..
 */
package com.jeespring.modules.test.dao.tree;

import com.jeespring.common.persistence.TreeDao;
import com.jeespring.common.persistence.annotation.MyBatisDao;
import org.apache.ibatis.annotations.Mapper;
import com.jeespring.modules.test.entity.tree.TestTree;

/**
 * 组织机构DAO接口
 * @author JeeSpring
 * @version 2018-08-03
 */
@Mapper
public interface TestTreeDao extends TreeDao<TestTree> {
	
}