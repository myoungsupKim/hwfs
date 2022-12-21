package com.hwfs.sc.scz.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.CustInchargeService;
import com.hwfs.sc.scz.service.ContractMgmtService;


 /**
 * 계약 정보를 관리하는 contractMgmt Controller
 *
 * @ClassName contractMgmtController.java
 * @Description contractMgmtController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/contractMgmt/")
public class ContractMgmtController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** contractMgmtService Bean 생성 */
	@Resource(name = "/sc/scz/contractMgmtService")
	private ContractMgmtService contractMgmtService;

	
	/**
	 * 계약 정보 목록을 조회한다.
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
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//계약 정보 을(를) 조회한다.
		RecordSet rs = contractMgmtService.selectList(parameter);
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_contract", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 이자율 정보 조회한다.
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
	@RequestMapping("selectRateList.xdo")
	public ModelAndView selectRateList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_rateSearch").get(0);
		
		//계약 정보 을(를) 조회한다.
		RecordSet rs = contractMgmtService.selectRateList(parameter);
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_rateSearch", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 계약 정보(을)를 Insert/Update/Delete 처리한다.
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
		//Map<String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter1 = param.get("ds_contract");

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//계약 정보을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> rtn = contractMgmtService.saveList(parameter1, loginDTO.getSabun(), loginDTO.getMuCd()); //, parameter2, inVar);
		int processCnt = Integer.parseInt(rtn.get("procCnt").toString());

		if (rtn.get("custList") != null)
		{
			RecordSet rs = (RecordSet)rtn.get("custList");

			//XPlatform으로 넘겨줄 Dataset을 설정한다.
			super.addOutDataSet(mav, "ds_contract", rs);
		}

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

}
