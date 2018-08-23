/**
 * * Copyright &copy; 2015-2020 <a href="https://gitee.com/JeeHuangBingGui/JeeSpring">JeeSpring</a> All rights reserved..
 */
package com.company.project.modules.ylttrip.dao;

import com.jeespring.common.persistence.InterfaceBaseDao;
import org.apache.ibatis.annotations.Mapper;
import com.company.project.modules.ylttrip.entity.TfTicket;

/**
 * 订单DAO接口
 * @author JeeSpring
 * @version 2018-08-16
 */
@Mapper
public interface TfTicketDao extends InterfaceBaseDao<TfTicket> {
	
}