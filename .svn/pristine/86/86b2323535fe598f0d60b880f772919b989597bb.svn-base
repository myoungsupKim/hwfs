package com.hwfs.fs.fsb.web;

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
import com.hwfs.fs.fsb.service.UpjangRemainVendorMgntService;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 *사업장기준정보 저장권한 관리 UpjangRemainVendorMgnt Controller
 * 
 * @ClassName UpjangRemainVendorMgntController.java
 * @Description UpjangRemainVendorMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.05.20    kihoon        최초생성
 * </pre>
 * @author 한화시스템/ICT : kihoon
 * @since 2019.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2019 by HANWHA CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsb/upjangRemainVendorMgnt/")
public class UpjangRemainVendorMgntController extends DefaultController {
	
	/** UpjangRemainVendorMgntService Bean 생성 */
	@Resource(name = "/fs/fsb/upjangRemainVendorMgntService")
	private UpjangRemainVendorMgntService upjangRemainVendorMgntService;
	
	/**
	 *  업장 기준정보 권한 목록 조회
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
	public ModelAndView selectFilterGubunCd2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = upjangRemainVendorMgntService.selectList(param.get("ds_searchRemainvendor").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_remainvendorList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
		
	/**
	 * 업장 기준정보 권한(을)를 Insert/Update/Delete 처리한다.
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//로그인 정보
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
				
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> param1 = xpDTO.getInVariableMap();
		
		DataSetMap dsList = param.get("ds_remainvendorList");
		
		//업장관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = upjangRemainVendorMgntService.saveList(dsList, loginDTO);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		super.addOutVariable(mav, "fv_saveMode", param1.get("action"));

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
