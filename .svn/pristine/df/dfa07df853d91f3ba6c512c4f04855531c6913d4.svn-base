package com.hwfs.rc.sle.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.rc.sle.service.OutletSalesService;
import com.hwfs.sc.cmn.util.FileUtil;

 /**
 * OutletSalesController에 대한 설명 작성
 * @ClassName OutletSalesController.java
 * @Description OutletSalesController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 25.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 8. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/sle/outletSales/")
public class OutletSalesController extends DefaultController {
	@Resource(name="/rc/sle/outletSalesService")
	private OutletSalesService outletSales;
	
	/**
	 * selectSalesInqList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectSalesInqList.xdo")
	public ModelAndView selectSalesInqList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_paramInfo").get(0);
		
		RecordSet rs = outletSales.selectSalesInqList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectSalesApprList.xdo")
	public ModelAndView selectSalesApprList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_paramInfo").get(0);
		
		RecordSet rs = outletSales.selectSalesApprList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * saveData1 기능 설명
	 * <pre>
	 * 파트장 승인
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveData1.xdo")
	public ModelAndView saveData1(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		//accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"전화번호"}));
		
		int procCnt =  outletSales.saveData1(parameter.get("ds_list"));
		                                                
		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * saveData1 기능 설명
	 * <pre>
	 * 팀장 승인
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveData2.xdo")
	public ModelAndView saveData2(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		//accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"전화번호"}));
		
		int procCnt =  outletSales.saveData2(parameter.get("ds_list"));
		                                                
		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * saveData3 기능 설명
	 * <pre>
	 * 첨부파일 저장
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveData3.xdo")
	public ModelAndView saveData3(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		//accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"전화번호"}));
		
		int procCnt =  outletSales.saveData3(parameter.get("ds_list2"));
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> param = parameter.get("ds_list2").get(0);
		
		String fileName = (String) param.get("fileName");
			
		// 파일저장소로 복사
        String sourceFile = propertiesService.getString("global.fileupload.path") + "/" + fileName;
        String targetFile;
        
        System.out.println("source : " + sourceFile);
        
        targetFile = propertiesService.getString("global.filerepository.path") + "/rc/sle" + "/"
                    + fileName;
        
        System.out.println("target : " +targetFile);
        
        boolean isCopied = false;

       
        // 파일 이동처리
        isCopied = FileUtil.copyFile(sourceFile, targetFile);
       
        if (!isCopied)
            //throw super.processException("fail.uploadfile.not.found");
		                                                
		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	
}
