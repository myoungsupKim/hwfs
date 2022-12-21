package com.hwfs.fm.fms.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fms.service.ReturnOrderBySalesService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 반환/교환/증정발주 ReturnOrderBySales Controller
 * 
 * @ClassName ReturnOrderBySalesController.java
 * @Description ReturnOrderBySalesController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.21    Jaey        최초생성
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fms/returnOrderBySales/")
public class ReturnOrderBySalesController extends DefaultController {
	
	/** ReturnOrderBySalesService Bean 생성 */
	@Resource(name = "/fm/fms/returnOrderBySalesService")
	private ReturnOrderBySalesService returnOrderBySalesService;

	/**
	 * 반환/교환/증정발주 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectReturnOrderBySalesList.xdo")
	public ModelAndView selectReturnOrderBySalesList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_Cond").get(0);

		//반환/교환/증정발주 조회
		RecordSet rs = returnOrderBySalesService.selectReturnOrderBySalesList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_List", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 반환 주문유형의 주문일자 선택시 정상주문 유형여부 확인
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectRtnOrderYn.xdo")
	public ModelAndView selectRtnOrderYn(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_Cond").get(0);

		RecordSet rs = returnOrderBySalesService.selectRtnOrderYn(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_List", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 반환/교환/증정발주를 Insert/Update 처리
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveReturnOrderBySalesInfo.xdo")
	public ModelAndView saveReturnOrderBySalesInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_IUD");

		try {
			//로그인 정보
			LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
	
			int processCnt =  returnOrderBySalesService.saveReturnOrderBySalesInfo(parameter, loginDTO);
			
			//XPlatform으로 넘겨줄 Dataset을 설정한다.
			super.addOutVariable(mav, "fv_processCnt", processCnt);
			
		} catch (BizException e){
			//에러 발생 시 에러메시지를 화면에 표시하지 않음-100
			return super.setResultSet(mav, -100, e.getMessage());
		} catch (Exception e) { 
    		//return super.setResultSet(mav, DefaultConsts.ERR_CODE, e.getMessage());
			throw e;
    	}
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}		
}
