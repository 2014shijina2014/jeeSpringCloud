/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/HuangBingGui/jeespring">jeespring</a> All rights reserved.
 */
package com.jeespring.common.web;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Scanner;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ckfinder.connector.configuration.Configuration;
import com.ckfinder.connector.configuration.Events;
import com.ckfinder.connector.data.AccessControlLevel;
import com.ckfinder.connector.utils.AccessControlUtil;
import com.ckfinder.connector.utils.PathUtils;
import com.jeespring.common.config.Global;
import com.jeespring.common.utils.FileUtils;
import com.jeespring.modules.sys.security.SystemAuthorizingRealm;
import com.jeespring.modules.sys.utils.UserUtils;

/**
 * CKFinder配置
 *
 * @author 黄炳桂 516821420@qq.com
 * @version 2014-06-25
 */
public class CKFinderConfig extends Configuration {

    public CKFinderConfig(ServletConfig servletConfig) {
        super(servletConfig);
    }

    @Override
    protected Configuration createConfigurationInstance() {
        SystemAuthorizingRealm.Principal principal = UserUtils.getPrincipal();
        if (principal == null) {
            return new CKFinderConfig(this.servletConf);
        }
        boolean isView = true;
        boolean isUpload = true;
        boolean isEdit = true;
        AccessControlLevel alc = this.getAccessConrolLevels().get(0);
        alc.setFolderView(isView);
        alc.setFolderCreate(isEdit);
        alc.setFolderRename(isEdit);
        alc.setFolderDelete(isEdit);
        alc.setFileView(isView);
        alc.setFileUpload(isUpload);
        alc.setFileRename(isEdit);
        alc.setFileDelete(isEdit);

        AccessControlUtil.getInstance(this).loadACLConfig();
        try {
            this.baseURL = FileUtils.path(Servlets.getRequest().getContextPath() + Global.USERFILES_BASE_URL + principal + "/");
            this.baseDir = FileUtils.path(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + principal + "/");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return new CKFinderConfig(this.servletConf);
    }

    @Override
    public boolean checkAuthentication(final HttpServletRequest request) {
        return UserUtils.getPrincipal() != null;
    }


    @Override
	public void init() throws Exception {
        DefaultResourceLoader loader = new DefaultResourceLoader();
        Resource resource = loader.getResource(this.xmlFilePath);
        Class<?> clazz = getClass().getSuperclass();
        Field field = clazz.getDeclaredField("lastCfgModificationDate");
        Method method = clazz.getDeclaredMethod("clearConfiguration");
        method.setAccessible(true);
        method.invoke(this);
        field.setAccessible(true);
        field.set(this, System.currentTimeMillis());
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(resource.getInputStream());
        doc.normalize();
        Node node = doc.getFirstChild();
        if (node != null) {
            NodeList nodeList = node.getChildNodes();

            for (int i = 0; i < nodeList.getLength(); ++i) {
                Node childNode = nodeList.item(i);
                if (childNode.getNodeName().equals("enabled"))
                    this.enabled = Boolean.valueOf(childNode.getTextContent().trim()).booleanValue();

                if (childNode.getNodeName().equals("baseDir")) {
                    this.baseDir = childNode.getTextContent().trim();
                    this.baseDir = PathUtils.escape(this.baseDir);
                    this.baseDir = PathUtils.addSlashToEnd(this.baseDir);
                }
                if (childNode.getNodeName().equals("baseURL")) {
                    this.baseURL = childNode.getTextContent().trim();
                    this.baseURL = PathUtils.escape(this.baseURL);
                    this.baseURL = PathUtils.addSlashToEnd(this.baseURL);
                }
                if (childNode.getNodeName().equals("licenseName"))
                    this.licenseName = childNode.getTextContent().trim();
                if (childNode.getNodeName().equals("licenseKey"))
                    this.licenseKey = childNode.getTextContent().trim();
                String value;
                if (childNode.getNodeName().equals("imgWidth")) {
                    value = childNode.getTextContent().trim();
                    value = value.replaceAll("//D", "");

                    try {
                        this.imgWidth = Integer.valueOf(value);
                    } catch (NumberFormatException var13) {
                        this.imgWidth = null;
                    }
                }
                if (childNode.getNodeName().equals("imgQuality")) {
                    value = childNode.getTextContent().trim();
                    value = value.replaceAll("//D", "");
                    method = clazz.getDeclaredMethod("adjustQuality", new Class[]{String.class});
                    method.setAccessible(true);
                    this.imgQuality = Float.parseFloat(method.invoke(this, value).toString());
                }
                if (childNode.getNodeName().equals("imgHeight")) {
                    value = childNode.getTextContent().trim();
                    value = value.replaceAll("//D", "");
                    try {
                        this.imgHeight = Integer.valueOf(value);
                    } catch (NumberFormatException var12) {
                        this.imgHeight = null;
                    }
                }
                if (childNode.getNodeName().equals("thumbs")) {
                    method = clazz.getDeclaredMethod("setThumbs", new Class[]{NodeList.class});
                    method.setAccessible(true);
                    method.invoke(this, childNode.getChildNodes());
                }
                if (childNode.getNodeName().equals("accessControls")) {
                    method = clazz.getDeclaredMethod("setACLs", new Class[]{NodeList.class});
                    method.setAccessible(true);
                    method.invoke(this, childNode.getChildNodes());
                }
                if (childNode.getNodeName().equals("hideFolders")) {
                    method = clazz.getDeclaredMethod("setHiddenFolders", new Class[]{NodeList.class});
                    method.setAccessible(true);
                    method.invoke(this, childNode.getChildNodes());
                }
                if (childNode.getNodeName().equals("hideFiles")) {
                    method = clazz.getDeclaredMethod("setHiddenFiles", new Class[]{NodeList.class});
                    method.setAccessible(true);
                    method.invoke(this, childNode.getChildNodes());
                }
                if (childNode.getNodeName().equals("checkDoubleExtension"))
                    this.doubleExtensions = Boolean.valueOf(childNode.getTextContent().trim()).booleanValue();
                if (childNode.getNodeName().equals("disallowUnsafeCharacters"))
                    this.disallowUnsafeCharacters = Boolean.valueOf(childNode.getTextContent().trim()).booleanValue();
                if (childNode.getNodeName().equals("forceASCII"))
                    this.forceASCII = Boolean.valueOf(childNode.getTextContent().trim()).booleanValue();
                if (childNode.getNodeName().equals("checkSizeAfterScaling"))
                    this.checkSizeAfterScaling = Boolean.valueOf(childNode.getTextContent().trim()).booleanValue();
                Scanner sc;
                if (childNode.getNodeName().equals("htmlExtensions")) {
                    value = childNode.getTextContent();
                    sc = (new Scanner(value)).useDelimiter(",");
                    while (sc.hasNext()) {
                        String val = sc.next();
                        if (val != null && !val.equals(""))
                            this.htmlExtensions.add(val.trim().toLowerCase());
                    }
                }
                if (childNode.getNodeName().equals("secureImageUploads"))
                    this.secureImageUploads = Boolean.valueOf(childNode.getTextContent().trim()).booleanValue();
                if (childNode.getNodeName().equals("uriEncoding"))
                    this.uriEncoding = childNode.getTextContent().trim();
                if (childNode.getNodeName().equals("userRoleSessionVar"))
                    this.userRoleSessionVar = childNode.getTextContent().trim();
                if (childNode.getNodeName().equals("defaultResourceTypes")) {
                    value = childNode.getTextContent().trim();
                    sc = (new Scanner(value)).useDelimiter(",");
                    while (sc.hasNext())
                        this.defaultResourceTypes.add(sc.next());
                }
                if (childNode.getNodeName().equals("plugins")) {
                    method = clazz.getDeclaredMethod("setPlugins", new Class[]{Node.class});
                    method.setAccessible(true);
                    method.invoke(this, childNode);

                }
                if (childNode.getNodeName().equals("basePathBuilderImpl")) {
                    method = clazz.getDeclaredMethod("setBasePathImpl", new Class[]{String.class});
                    method.setAccessible(true);
                    method.invoke(this, childNode.getTextContent().trim());
                }
            }
        }
        method = clazz.getDeclaredMethod("setTypes", new Class[]{Document.class});
        method.setAccessible(true);
        method.invoke(this, doc);
        field = clazz.getDeclaredField("events");
        field.setAccessible(true);
        field.set(this, new Events());
        this.registerEventHandlers();
    }
}
