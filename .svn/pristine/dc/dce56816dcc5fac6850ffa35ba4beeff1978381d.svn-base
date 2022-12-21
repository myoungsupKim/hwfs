package com.hwfs.sm.stm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sm.stm.service.TaxInvoiceMgntManualService;


 /**
 * 세금계산서 발행을 관리하는 TaxInvoiceMgntManual Controller
 * 
 * @ClassName TaxInvoiceMgntManualController.java
 * @Description TaxInvoiceMgntManualController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.10    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 Yu
 * @since 2015.06.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/stm/taxInvoiceMgntManual/")
public class TaxInvoiceMgntManualController extends DefaultController {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TaxInvoiceMgntManualService Bean 생성 */
	@Resource(name = "/sm/stm/taxInvoiceMgntManualService")
	private TaxInvoiceMgntManualService taxInvoiceMgntManualService;
	
	/**
	 * 세금계산서 발행(본사용) 목록을 조회한다.
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
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//세금계산서 발행(본사용) 을(를) 조회한다.
		RecordSet rs = taxInvoiceMgntManualService.selectList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		
		if(parameter.get("taxShetNum") != null && !parameter.get("taxShetNum").equals("")){
			RecordSet rsDtl = taxInvoiceMgntManualService.selectTaxShetDetailList(parameter);
			super.addOutDataSet(mav, "ds_dtlList", rsDtl);
		}

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 세금계산서 발행(본사용)(을)를 등록한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap taxShetMst = param.get("ds_taxShetMst");
		DataSetMap taxShetDtl = param.get("ds_taxShetDtl");		

		//세금계산서 발행(본사용)을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = taxInvoiceMgntManualService.saveTaxInvoice(taxShetMst, taxShetDtl);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 세금계산서 발행(본사용) 업장정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectUpjangInfo.xdo")
	public ModelAndView selectUpjangInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//세금계산서 발행(본사용) 을(를) 조회한다.
		RecordSet rs = taxInvoiceMgntManualService.selectUpjangInfo(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_upjang", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 세금계산서 발행(본사용) 업장 담당자정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectInchargeInfo.xdo")
	public ModelAndView selectInchargeInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//세금계산서 발행(본사용) 을(를) 조회한다.
		RecordSet rs = taxInvoiceMgntManualService.selectInchargeInfo(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_incharge", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 
	 * 세금계산서 요청
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("taxInvoiceRequest.xdo")
	public ModelAndView taxInvoiceRequest(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
			HttpServletRequest request) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_taxNumList");
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		String reqStatus = (String)inVar.get("reqStatus");		//요청상태
		
		LoginDTO loginDto = (LoginDTO)SessionUtil.getLoginSession(request);

		//카드 Prefix을(를) 등록, 수정, 삭제 처리한다.
		//RecordSet rs = TaxInvoiceMgntManualService.taxInvoiceRequest(parameter);
		Map<String, Object> map = taxInvoiceMgntManualService.taxInvoiceRequest(parameter, reqStatus, loginDto);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		//super.addOutDataSet(mav, "ds_rtn", rs);
		super.addOutDataSet(mav, "fv_successYn", map.get("successYn"));
		super.addOutDataSet(mav, "fv_errCode", map.get("errCode"));
		super.addOutDataSet(mav, "fv_errMsg", map.get("errMsg"));
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 세금계산서 발행(본사용)(을)를 등록한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	/* @SuppressWarnings("unchecked")*/
	@RequestMapping("deleteTaxInvoice.xdo")
	public ModelAndView deleteTaxInvoice(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_taxShetMst");
		
		//세금계산서 발행(본사용)을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = taxInvoiceMgntManualService.deleteTaxInvoice(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 수정 세금계산서- 계약의 해제(을)를 등록한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveConcellation.xdo")
	public ModelAndView saveConcellation(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap taxShetMst = param.get("ds_taxShetMst");
		DataSetMap taxShetDtl = param.get("ds_taxShetDtl");
		

		//세금계산서 발행(본사용)을(를) 등록, 수정, 삭제 처리한다.
		Map<String, String> returnValue = taxInvoiceMgntManualService.saveConcellation(taxShetMst, taxShetDtl);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", returnValue.get("processCnt"));
		
		if(!StringUtils.isEmpty(returnValue.get("concellationTaxNum"))){
			super.addOutVariable(mav, "fv_concellationTaxNum", returnValue.get("concellationTaxNum"));
		}
		
		if(!StringUtils.isEmpty(returnValue.get("correctionTaxNum"))){
			super.addOutVariable(mav, "fv_correctionTaxNum", returnValue.get("correctionTaxNum"));
		}
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}

