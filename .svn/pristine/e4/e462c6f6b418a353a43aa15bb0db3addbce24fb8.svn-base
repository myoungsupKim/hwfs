package com.hwfs.sc.scp.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.scp.service.PersAccessLogService;


 /**
 * 개인정보 접근로그를 조회하는 PersAccessLog Controller
 * 
 * @ClassName PersAccessLogController.java
 * @Description PersAccessLogController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scp/persAccessLog/")
public class PersAccessLogController extends DefaultController {
	
	/** PersAccessLogService Bean 생성 */
	@Resource(name = "/sc/scp/persAccessLogService")
	private PersAccessLogService persAccessLogService;
	
	/**
	 * 개인정보 접근로그 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		@SuppressWarnings("unchecked")
		Map <String, Object> inVar = param.get("ds_search").get(0);
		
		//페이지 파라미터 설정
		@SuppressWarnings("unchecked")
		Map <String, Object> pageInfo = param.get("ds_pageInfo").get(0);
		pageInfo.put("firstIndex", (( Integer.parseInt(pageInfo.get ("currentPage").toString()) - 1 ) * Integer.parseInt(pageInfo.get("volumePerPage").toString()) ));
		
		//조회 조건 Map을 합친다.
		inVar.putAll(pageInfo);	
		
		//개인정보 접근로그 을(를) 조회한다.
		RecordSet rs = persAccessLogService.selectListPerPage(inVar);

		//개인정보 접근로그 목록 대상 전체 건수를 조회한다.
		int totalCount = persAccessLogService.selectTotalCnt(inVar);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전체 조회 대상 건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_totalCount", totalCount);
				
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 개인정보 열람승인을 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("approveList.xdo")
	public ModelAndView approveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//개인정보처리등급을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = persAccessLogService.saveApproveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 개인정보 열람승인취소를 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("approveCancelList.xdo")
	public ModelAndView approveCancelList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//개인정보처리등급을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = persAccessLogService.saveApproveCancelList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
