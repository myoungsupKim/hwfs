package com.hwfs.sc.scz.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.scz.service.SapInterfaceRetrieveService;


 /**
 * SAP 인터페이스 내역을 조회하는 SapInterfaceRetrieve Controller
 * 
 * @ClassName SapInterfaceRetrieveController.java
 * @Description SapInterfaceRetrieveController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.02    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.09.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/sapInterfaceRetrieve/")
public class SapInterfaceRetrieveController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapInterfaceRetrieveService Bean 생성 */
	@Resource(name = "/sc/scz/sapInterfaceRetrieveService")
	private SapInterfaceRetrieveService sapInterfaceRetrieveService;
	
	/**
	 * 계정코드 마지막 수신일자 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectInitData.xdo")
	public ModelAndView selectInitData(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		//Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//페이지의 기초정보를 조회한다.(원래는 서비스에서 조회해야 되는뎅... 귀찮다.
		RecordSet rs = sapInterfaceRetrieveService.selectAcctMstLastDate();
		RecordSet rs1 = sapInterfaceRetrieveService.selectSlipLastDate();
		RecordSet rs2 = sapInterfaceRetrieveService.selectSlipType();
		RecordSet rs3 = sapInterfaceRetrieveService.selectCustLastDate();
		RecordSet rs4 = sapInterfaceRetrieveService.selectCcLastDate();
		RecordSet rs5 = sapInterfaceRetrieveService.selectTaxShetLastDate();

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_acctMstLastDate", rs);
		super.addOutDataSet(mav, "ds_slipLastDate", rs1);
		super.addOutDataSet(mav, "ds_slipType", rs2);
		super.addOutDataSet(mav, "ds_custLastDate", rs3);
		super.addOutDataSet(mav, "ds_ccLastDate", rs4);
		super.addOutDataSet(mav, "ds_taxShetLastDate", rs5);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 계정코드 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectAcctMst.xdo")
	public ModelAndView selectAcctMst(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectAcctMst(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_acctMst", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 전표마스터 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSlipMst.xdo")
	public ModelAndView selectSlipMst(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectSlipMst(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_slipMst", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 전표디테일 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSlipDtl.xdo")
	public ModelAndView selectSlipDtl(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectSlipDtl(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_slipDtl", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 전표상태 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSlipStatus.xdo")
	public ModelAndView selectSlipStatus(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectSlipStatus(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_slipStatus", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 전표취소 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSlipCancel.xdo")
	public ModelAndView selectSlipCancel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectSlipCancel(inVar);
 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_slipCancel", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 거래처 요청 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCustRequest.xdo")
	public ModelAndView selectCustRequest(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectCustRequest(inVar);
 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_custRequest", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 거래처 요청결과 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCustResponse.xdo")
	public ModelAndView selectCustResponse(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectCustResponse(inVar);
 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_custResponse", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조직 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCc.xdo")
	public ModelAndView selectCc(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectCc(inVar);
		RecordSet rs1 = sapInterfaceRetrieveService.selectCcLog(inVar);
 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_cc", rs);
		super.addOutDataSet(mav, "ds_ccLog", rs1);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 세금계산서 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectTaxShetHdr.xdo")
	public ModelAndView selectTaxShetHdr(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs = sapInterfaceRetrieveService.selectTaxShetHdr(inVar);
 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_taxShetHdr", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 세금계산서 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectTaxShetItem.xdo")
	public ModelAndView selectTaxShetItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//SAP 인터페이스( ) 을(를) 조회한다.
		RecordSet rs1 = sapInterfaceRetrieveService.selectTaxShetItem(inVar);
		RecordSet rs2 = sapInterfaceRetrieveService.selectTaxShetPublish(inVar);
		RecordSet rs3 = sapInterfaceRetrieveService.selectTaxShetAttach(inVar);
		RecordSet rs4 = sapInterfaceRetrieveService.selectTaxShetPublishStatus(inVar);
		RecordSet rs5 = sapInterfaceRetrieveService.selectTaxShetStatus(inVar);
		RecordSet rs6 = sapInterfaceRetrieveService.selectTaxShetNtsStatus(inVar);
 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_taxShetItem", rs1);
		super.addOutDataSet(mav, "ds_taxShetPublish", rs2);
		super.addOutDataSet(mav, "ds_taxShetAttach", rs3);
		super.addOutDataSet(mav, "ds_taxShetPublishStatus", rs4);
		super.addOutDataSet(mav, "ds_taxShetStatus", rs5);
		super.addOutDataSet(mav, "ds_taxShetNtsStatus", rs6);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}




























}
