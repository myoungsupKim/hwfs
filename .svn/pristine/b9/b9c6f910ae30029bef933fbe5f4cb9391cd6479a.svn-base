package com.hwfs.fm.fmc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fmc.service.ClaimProcService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 클레임처리하는 ClaimProc Controller
 * 
 * @ClassName ClaimProcController.java
 * @Description ClaimProcController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.21    최영준        최초생성
 *  2021.08.17    DEV02         [PJT]주문채널통합
 * </pre>
 * @author FC종합전산구축 :  통합영업 최영준
 * @since 2015.05.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmc/claimProc/")
public class ClaimProcController extends DefaultController {
	
	/** ClaimProcService Bean 생성 */
	@Resource(name = "/fm/fmc/claimProcService")
	private ClaimProcService claimProcService;
	
	/**
	 * 클레임처리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
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
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//클레임처리 을(를) 조회한다.
		RecordSet rs = claimProcService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 클레임처리 목록을 조회한다.
	 * [PJT]주문채널통합
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectBrandList.xdo")
	public ModelAndView selectBrandList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//클레임처리 을(를) 조회한다.
		RecordSet rs = claimProcService.selectBrandList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 아이템 코드를 가져온다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("returnItemSearch.xdo")
	public ModelAndView returnItemSearch(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);

		//반품자재조회
		RecordSet rs = claimProcService.returnItemSearch(parameter, inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	

	/**
	 * 클레임처리(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		
		Map<String, Object> processResult = new HashMap<String, Object>();
		String serviceRtnMsg = "";
		int fv_processCnt = 0;

		//클레임처리을(를) 등록, 수정, 삭제 처리한다.
		try {
			//Map<String, Object> processResult = claimProcService.saveList(parameter, loginDTO);
			processResult = claimProcService.saveList(parameter, loginDTO);
		} catch (Exception e) {
			// TODO: handle exception
			
			serviceRtnMsg =  e.getMessage();
			
			if(serviceRtnMsg.indexOf("^") > 0) {
				fv_processCnt = 200; // HNRIF 오류로 히스토리 저장 필요 
			} else {
				fv_processCnt = 100; // 서비스 오류
			}
			
			//System.out.println("return msg indexof >> "+serviceRtnMsg.indexOf("^"));
			//System.out.println("Controller processResult --> " + fv_processCnt + "/ " + serviceRtnMsg);
		}
		

		//처리건수를 OutVariable에 설정한다.
		
		//super.addOutVariable(mav, "fv_msg", processResult.get("msg"));
		super.addOutVariable(mav, "fv_msg", serviceRtnMsg);
		super.addOutVariable(mav, "fv_processCnt", fv_processCnt);
		if(processResult.size() > 0 && "E".equals(processResult.get("O_RTN_CD"))){
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, processResult.get("O_RTN_MSG").toString());
		}

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 클레임처리 [처리취소] 처리된 클레임을 다시 요청상태로 변경한다.  - 교환 처리된 클레임만 가능.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("cancelList.xdo")
	public ModelAndView cancelList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//클레임처리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = claimProcService.cancelList(parameter);

		//처리건수를 OutVariable에 설정한다.
		
		
		super.addOutVariable(mav, "fv_processCnt", processCnt);
				//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 클레임처리 [요청] 처리된 클레임을 삭제 HIST 테이블에 저장한다. [요청취소] 상태가 된다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("reqCancelList.xdo")
	public ModelAndView reqCancelList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//클레임처리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = claimProcService.reqCancelList(parameter);

		//처리건수를 OutVariable에 설정한다.
		
		
		super.addOutVariable(mav, "fv_processCnt", processCnt);
				//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/* 클레임 리조크IF 결과 저장 */
	@RequestMapping("saveHnrIfHist.xdo")
	public ModelAndView saveHnrIfHist(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		int fv_processCnt = claimProcService.saveHnrIfHist(parameter, loginDTO);
		
		super.addOutVariable(mav, "fv_processCnt", fv_processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
