package com.hwfs.fs.fsl.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fs.fsl.service.UpjangSaleRegMgntService;


 /**
 * 급식의 매출(식권/장례식장 등)을 관리하는 화면이다.하는 UpjangSaleRegMgnt Controller
 * 
 * @ClassName UpjangSaleRegMgntController.java
 * @Description UpjangSaleRegMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 손형민
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsl/upjangSaleRegMgnt/")
public class UpjangSaleRegMgntController extends DefaultController {
	
	/** UpjangSaleRegMgntService Bean 생성 */
	@Resource(name = "/fs/fsl/upjangSaleRegMgntService")
	private UpjangSaleRegMgntService upjangSaleRegMgntService;

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	/**
	 * 매출등록 목록을 조회한다.
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
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출등록 을(를) 조회한다.
		Map<String, RecordSet> rs = upjangSaleRegMgntService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("list"));
		super.addOutDataSet(mav, "ds_listSysClass", rs.get("listSysClass"));
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectSgList.xdo")
	public ModelAndView selectSgList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//logger.debug("param : " + param);
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		logger.debug("parameter : " + parameter);
			   
		//매출등록 을(를) 조회한다.
		Map<String, RecordSet> rs = upjangSaleRegMgntService.selectSgList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("list"));
		super.addOutDataSet(mav, "ds_listStat", rs.get("listStat"));
		super.addOutDataSet(mav, "ds_listStat2", rs.get("listStat2"));
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 업장 CC_CD를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectUpjangCcCdInfo.xdo")
	public ModelAndView selectUpjangCcCdInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출등록 을(를) 조회한다.
		RecordSet rs = upjangSaleRegMgntService.selectUpjangCcCdInfo(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_cccd", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 매출등록(을)를 Insert/Update/Delete 처리한다.
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_list");
		DataSetMap listSave = param.get("ds_listSave");
		DataSetMap parameterTicket = param.get("ds_list_ticket");
		DataSetMap advanceAmt = param.get("ds_advanceAmt");
		
		//매출등록을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = upjangSaleRegMgntService.saveList(list, listSave, parameterTicket, advanceAmt);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 식권팝업용 번호를  생성한다
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
	@RequestMapping("selectTmpSeq.xdo")
	public ModelAndView selectTmpSeq(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);

		//매출등록을(를) 등록, 수정, 삭제 처리한다.
		RecordSet rs = upjangSaleRegMgntService.selectTmpSeq(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_tmpSeq", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

	}
	
	
	/**
	 * 창고 목록을 조회한다.
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
	@RequestMapping("posClass.xdo")
	public ModelAndView posClassList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출등록 을(를) 조회한다.
		RecordSet rs = upjangSaleRegMgntService.posClassList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_posYn", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 회수예정일을 조회한다.
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
	@RequestMapping("selectExpDt.xdo")
	public ModelAndView selectExpDt(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);

		//매출등록을(를) 등록, 수정, 삭제 처리한다.
		RecordSet rs = upjangSaleRegMgntService.selectExpDt(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_exptDt", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

	}
	
	
	/**
	 * 마감체크를 조회한다.
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
	@RequestMapping("beforeDt.xdo")
	public ModelAndView beforeDt(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출등록 을(를) 조회한다.
		RecordSet rs = upjangSaleRegMgntService.beforeDt(parameter); 

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_beforeDt", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	
		
	}
	/**
	 * 마감체크(전일자)를 조회한다.
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
	@RequestMapping("beforeDt2.xdo")
	public ModelAndView beforeDt2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출등록 을(를) 조회한다.
		RecordSet rs = upjangSaleRegMgntService.beforeDt2(parameter); 
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_beforeDt2", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
	/**
	 * 전일자 마감체크를 조회한다.
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
	@RequestMapping("beforeDtCopy.xdo")
	public ModelAndView beforeDtCopy(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출등록 을(를) 조회한다.
		RecordSet rs = upjangSaleRegMgntService.beforeDtCopy(parameter); 

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_beforeDtCopy", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
	/**
	 * 상품권 조회한다.
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
	@RequestMapping("evCnt.xdo")
	public ModelAndView evCnt(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출등록 을(를) 조회한다.
		RecordSet rs = upjangSaleRegMgntService.evCnt(parameter); 

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_evidence2", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
	
	/**
	 * 선수금잔액합계를 조회한다(선수식권)
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
	@RequestMapping("selectSumAdvanceAmtTicketP2.xdo")
	public ModelAndView selectSumAdvanceAmtTicketP2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//선수금잔액합계를 조회한다
		RecordSet rs = upjangSaleRegMgntService.selectSumAdvanceAmtTicketP2(parameter); 

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listAdvanceTicketP2", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
	/**
	 * 선수금잔액합계를 조회한다(외상식권)
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
	@RequestMapping("selectSumAdvanceAmtTicketP3.xdo")
	public ModelAndView selectSumAdvanceAmtTicketP3(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//선수금잔액합계를 조회한다
		RecordSet rs = upjangSaleRegMgntService.selectSumAdvanceAmtTicketP3(parameter); 

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listAdvanceTicketP3", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
	/**
	 * 건별권한을 갖기위한 기획자 승인여부 
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCloseModifyreq.xdo")
	public ModelAndView selectCloseModifyreq(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//선수금잔액합계를 조회한다
		RecordSet rs = upjangSaleRegMgntService.selectCloseModifyreq(parameter); 

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_apprv", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
	/**
	 * 사업장별 오픈일자 가져 오기 
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("searchOpenDate.xdo")
	public ModelAndView selectOpenDate(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap(); 
		
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//선수금잔액합계를 조회한다
		RecordSet rs = upjangSaleRegMgntService.selectOpenDate(parameter); 

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_openDate", rs);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
}
