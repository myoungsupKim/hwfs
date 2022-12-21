package com.hwfs.fs.fsb.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fs.fsb.service.UpjangPackMgntService;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 업장관리하는 UpjangPackMgnt Controller
 * 
 * @ClassName UpjangPackMgntController.java
 * @Description UpjangPackMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최문규
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsb/upjangPackMgnt/")
public class UpjangPackMgntController extends DefaultController {
	
	/** UpjangPackMgntService Bean 생성 */
	@Resource(name = "/fs/fsb/upjangPackMgntService")
	private UpjangPackMgntService upjangPackMgntService;
	
	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/**
	 * Combo 코드목록을 조회한다.
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
	@SuppressWarnings("unchecked")
	@RequestMapping("selectCode.xdo")
	public ModelAndView selectCode(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//정산집계관리 을(를) 조회한다.
		Map<String, RecordSet> rs = upjangPackMgntService.selectCode(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_job", rs.get("job"));
		super.addOutDataSet(mav, "ds_subJob", rs.get("subJob"));
		super.addOutDataSet(mav, "ds_jobCd", rs.get("job"));
		super.addOutDataSet(mav, "ds_subJobCd", rs.get("subJob"));
		super.addOutDataSet(mav, "ds_locCd", rs.get("loc"));
		super.addOutDataSet(mav, "ds_subLocCd", rs.get("subLoc"));
		super.addOutDataSet(mav, "ds_permissionType", rs.get("permission"));

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 *  식단가현황 메뉴구분코드 조회한다.
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
	@RequestMapping("selectFilterGubunCd2.xdo")
	public ModelAndView selectFilterGubunCd2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = upjangPackMgntService.selectFilterGubunCd2(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_gubunCd2", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 회계정보(Tab1),운영현황(Tab2),계약정보(Tab3)를 조회한다.
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
	@RequestMapping("selectAccountingInfo.xdo")
	public ModelAndView selectAccountingInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//판매상품군 정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		Map<String, RecordSet> rs = upjangPackMgntService.selectAccountingInfo(param.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_accountingInfo", rs.get("account"));
		super.addOutDataSet(mav, "ds_bankList", rs.get("bank"));
		super.addOutDataSet(mav, "ds_memberInfo", rs.get("memberInfo"));
		super.addOutDataSet(mav, "ds_jikchakHistory", rs.get("jikchakHistory"));
		super.addOutDataSet(mav, "ds_memberCount", rs.get("memberCount"));
		super.addOutDataSet(mav, "ds_memberCount2", rs.get("memberCount2"));
		super.addOutDataSet(mav, "ds_mpriceInfo", rs.get("mpriceInfo"));
		super.addOutDataSet(mav, "ds_detailAddr", rs.get("detailAddr"));
		
		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수 
		accessLogService.readLog(param.get("ds_search").get(0), rs.get("account").size());
		accessLogService.readLog(param.get("ds_search").get(0), rs.get("bank").size());
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 업장관리 목록, 기기보유현황을 조회한다.
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
	@SuppressWarnings("unchecked")
	@RequestMapping("selectUpjangPackMgnt.xdo")
	public ModelAndView selectUpjangPackMgnt(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//업장관리 을(를) 조회한다.
		Map<String, RecordSet> rs = upjangPackMgntService.selectUpjangPackMgnt(param.get("ds_search").get(0));
		
		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (param.get("ds_search").size() > 0) {
			Map<String, Object> map = param.get("ds_search").get(0);
			if (map.get("refSeq") != null)
				strRefSeq =  map.get("refSeq").toString(); //필드명이 "imgPath"인 경우임
		}
		
		//첨부파일 조회 Service 호출
		@SuppressWarnings("rawtypes")
		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_historyList", rs.get("deptHistory"));
		super.addOutDataSet(mav, "ds_remainmealdtl", rs.get("remainmealdtl"));
		super.addOutDataSet(mav, "ds_utensil", rs.get("utensil"));
		super.addOutDataSet(mav, "ds_custMgnt", rs.get("cust"));
		super.addOutDataSet(mav, "ds_docList", rs.get("doc"));
		super.addOutDataSet(mav, "ds_mpriceHistory", rs.get("mpriceHistory"));
		super.addOutDataSet(mav, "ds_respMealList", rs.get("respMeal"));
		super.addOutDataSet(mav, "ds_guarantyAmtInfo", rs.get("guarantyAmt"));		
		super.addOutDataSet (mav, "ds_file", fileList);	//첨부파일 정보
		
		accessLogService.readLog(param.get("ds_search").get(0), rs.get("cust").size());
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 계약정보(TAB3) 총투자실적, 보증금잔액, 미상각잔액 조회한다.
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
	@RequestMapping("selectInvAmt.xdo")
	public ModelAndView selectInvAmt(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = upjangPackMgntService.selectInvAmt(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_invAmt", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 인원현황(TAB5) 발령History 목록을 조회한다.
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
	@RequestMapping("selectMemberHistory.xdo")
	public ModelAndView selectMemberHistory(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = upjangPackMgntService.selectMemberHistory(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_memberHistory", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 예산현황(TAB7) 목록을 조회한다.
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
	@RequestMapping("selectBudgetInfo.xdo")
	public ModelAndView selectBudgetInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = upjangPackMgntService.selectBudgetInfo(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_budgetInfo", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 임대/보증금 현황(TAB8) 목록을 조회한다.
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
	@RequestMapping("selectGuarantyAmtInfo.xdo")
	public ModelAndView selectGuarantyAmtInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = upjangPackMgntService.selectGuarantyAmtInfo(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_guarantyAmtInfo", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 기기보유현황(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveUtensil.xdo")
	public ModelAndView saveUtensil(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap dsUtensil = param.get("ds_utensil");
		

		//업장관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = upjangPackMgntService.saveUtensil(dsUtensil);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 고객사현황(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveCustInfo.xdo")
	public ModelAndView saveCustInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap dsSearch = param.get("ds_search");
		DataSetMap dsCustMgnt = param.get("ds_custMgnt");
		

		//업장관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = upjangPackMgntService.saveCustInfo(dsSearch, dsCustMgnt);
		
		//개인정보보호 접근로그를 쌓는다.
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"HP_TEL_ENC, E_MAIL_ENC, COM_TEL_ENC, HOME_ADDR_ENC"}));
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 식단가현황(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveMpriceInfo.xdo")
	public ModelAndView saveMpriceInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap dsMpriceInfo = param.get("ds_mpriceInfo");
		
		//업장관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = upjangPackMgntService.saveMpriceInfo(dsMpriceInfo);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장관리(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveAccountingInfo.xdo")
	public ModelAndView saveAccountingInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {
		
		//로그인 정보
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//서비스 호출 후 첨부참조일련번호가 반환된다.(업장관리을(를) 등록, 수정, 삭제 처리한다.)
		String strRefSeq = upjangPackMgntService.saveAccountingInfo(param, loginDTO);

		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		super.addOutVariable(mav, "fv_RefSeq", strRefSeq);

		//(중요)첨부파일정보가 바뀌므로 재조회 하여 클라이언트에 전달한다.
		//첨부파일 조회 Service 호출
		if (!strRefSeq.equals("")) {
			@SuppressWarnings("rawtypes")
			List<Map>fileList = attachFileService.selectList(strRefSeq);
			super.addOutDataSet (mav, "ds_file", fileList);
		}
		
		//개인정보보호 접근로그를 쌓는다.
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"UPJANG_TEL_ENC, CHARGE_SABUNHP_ENC"}));
		
		//처리건수를 OutVariable에 설정한다.
		//super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
