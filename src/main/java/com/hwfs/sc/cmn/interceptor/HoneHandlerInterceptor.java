package com.hwfs.sc.cmn.interceptor;

import com.tobesoft.xplatform.data.PlatformData;
import com.tobesoft.xplatform.tx.PlatformException;
import com.tobesoft.xplatform.tx.PlatformRequest;

import hone.core.HoneException;
import hone.core.context.request.RequestContext;
import hone.core.context.request.RequestContextHolder;
import hone.online.web.client.ClientInfo;
import hone.online.web.client.ClientType;
import hone.online.web.client.ClientUtils;
import hone.online.web.client.RequestType;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.client.XplatformClientDetector;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

 /**
 * Hone Handler Interceptor 버그 추적을 위해 임시로 생성
 * @ClassName HoneHandlerInterceptor.java
 * @Description HoneHandlerInterceptor Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 10. 16.   HONE팀     버그추적을 위해 생성
 * </pre>
 * @author FC종합전산구축 : HONE팀
 * @since 2015. 10. 16.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class HoneHandlerInterceptor extends HandlerInterceptorAdapter {
	  private final Logger logger = LoggerFactory.getLogger (this.getClass());
	  //private RequestContext requestContext;    2015.12.28
	  private String encoding;
	  
	  public void setEncoding(String encoding)
	  {
	    this.encoding = encoding;
	  }
	  
	  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	    throws Exception
	  {
		logger.debug("#############################################   " + Thread.currentThread().getName() + "." + Thread.currentThread().getId() + " Interceptor preHandle started");
	    try
	    {
	      ClientInfo clientInfo = ClientUtils.getClientInfo(request);
	      if ((clientInfo != null) && (clientInfo.getClientType().equals(new ClientType("XPLATFORM"))))
	      {
	        String platformType = "PlatformXml";
	        
	        RequestType requestType = clientInfo.getRequestType();
	        if (XplatformClientDetector.BINARY_REQUEST.equals(requestType)) {
	          platformType = "PlatformBinary";
	        }
	        PlatformRequest platformRequest = 
	          new PlatformRequest(request.getInputStream(), platformType, this.encoding);
	        
	        platformRequest.receiveData();
	        PlatformData platformData = platformRequest.getData();
	        
	        logger.debug("#############################################  " + Thread.currentThread().getName() + "." + Thread.currentThread().getId() + " recevieData : " + platformRequest.getData().toString());
	        logger.debug("########################################AAAAA  " + "platformType["+platformType +"]"+"requestType["+requestType+"]");
	        
	        //this.requestContext = RequestContextHolder.getRequestContext();    2015.12.28
	        //this.requestContext.setAttribute("PLATFORM_DATA", platformData);   2015.12.28
	        RequestContextHolder.getRequestContext().setAttribute(XplatformConstants.PLATFORM_DATA_REQUEST_KEY, platformData);
	      }
	    }
	    catch (IOException e)
	    {
	      throw new HoneException("Failed to create PlatformRequest", e);
	    }
	    catch (PlatformException e)
	    {
	      throw new HoneException("Failed to receive data from PlatformRequest", e);
	    }
	    logger.debug("############################ " + Thread.currentThread().getName() + "." + Thread.currentThread().getId() + " Interceptor preHandle end");
	    return super.preHandle(request, response, handler);
	  }
	  
	  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
	    throws Exception
	  {
		// 2015.12.28  
	    //if (this.requestContext != null)
	    //{
	    //  this.requestContext = null;
	    //  RequestContextHolder.remove();
	    //}
		  
  	    RequestContextHolder.remove();  
	    super.postHandle(request, response, handler, modelAndView);
	  }
	  
	  public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
	    throws Exception
	  {
	   // 2015.12.28
	   // if (this.requestContext != null)
	   // {
	   //  this.requestContext = null;
	   //   RequestContextHolder.remove();
	   // }
		  
        RequestContextHolder.remove();  
	    super.afterCompletion(request, response, handler, ex);
	  }
}
