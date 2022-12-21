package com.hwfs.fs.fsf.web;

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
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fs.fsf.service.FuneralPatronMstRegService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 고인등록하는 FuneralPatronMstReg Controller
 * 
 * @ClassName FuneralPatronMstRegController.java
 * @Description FuneralPatronMstRegController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    백정훈        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백정훈
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsf/funeralPatronMstReg/")
public class FuneralPatronMstRegController extends DefaultController {
	
	/** FuneralPatronMstRegService Bean 생성 */
	@Resource(name = "/fs/fsf/funeralPatronMstRegService")
	private FuneralPatronMstRegService funeralPatronMstRegService;
	
	/**
	 * 고인Master 등록관리 화면 목록을 조회한다.
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

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//고인 및 상주 등록관리 화면 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = funeralPatronMstRegService.selectList(param.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_deadInfoReg", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 고인 가족관리 등록관리 화면 목록을 조회한다.
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
	@RequestMapping("selectDtlList.xdo")
	public ModelAndView selectDtlList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//고인 및 상주 등록관리 화면 을(를) 조회한다.
		RecordSet rs = funeralPatronMstRegService.selectDtlList(param.get("ds_search").get(0));
		
		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
	    accessLogService.readLog(param.get("ds_search").get(0), rs.size());
	    
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_chierMournerInfoReg", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 고인Master, 고인 등록관리 화면(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//고인Master 등록관리 화면을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> rMap = funeralPatronMstRegService.saveList(param, loginDTO.getSabun());
				
		//개인정보보호 접근로그를 쌓는다.
	//    accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"CHIEF_MOURNER_TELNO_ENC, CHIEF_MOURNER_ADDR, CHIEF_MOURNER_ADDR_ENC"}));
		
		//처리건수를 OutVariable에 설정한다.
	    super.addOutVariable(mav, "fv_dupCnt", rMap.get("dupCnt"));
		super.addOutVariable(mav, "fv_processCnt", rMap.get("procCnt"));

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 고인및 상주상세정보 화면 목록을 조회한다.
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
	@RequestMapping("selectGuestDtlList.xdo")
	public ModelAndView selectGuestDtlList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//고인 및 상주 등록관리 화면 을(를) 조회한다.
		RecordSet rs = funeralPatronMstRegService.selectGuestDtlList(param.get("ds_search").get(0));
		
		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
	    accessLogService.readLog(param.get("ds_search").get(0), rs.size());
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_guestDtl", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
