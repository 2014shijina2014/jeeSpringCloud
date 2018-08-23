/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeespring.modules.tools.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeespring.common.web.AbstractBaseController;

/**
 * 表单构建工具
 * @author lgf
 * @version 2016-01-07
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/beautifyhtml")
public class BeautifyHtmlController extends AbstractBaseController {

	
	/**
	 * 打开表单构建工具
	 */
	@RequestMapping(value = {"index", ""})
	public String index( HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/tools/form_builder";
	}

		
}