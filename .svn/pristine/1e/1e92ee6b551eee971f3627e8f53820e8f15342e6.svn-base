package com.hwfs.rc.bms.web;

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
import com.hwfs.rc.bms.service.EventMgmtService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;

 /**
 * EventMgmtController에 대한 설명 작성
 * @ClassName EventMgmtController.java
 * @Description EventMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 30.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 6. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/bms/eventMgmt/")
public class EventMgmtController extends DefaultController {
	@Resource(name="/rc/bms/eventMgmtService")
	private EventMgmtService eventMgmt;
	
	
	/** File Attach Service Bean 생성 검색시 필요함*/
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	
	//중복 예약 체크
	@SuppressWarnings("unchecked")
	@RequestMapping("reservDuplicationCheck.xdo")
	public ModelAndView reservDuplicationCheck(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		RecordSet rs = eventMgmt.reservDuplicationCheck(parameter.get("ds_paramInfoDuplication").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter.get("ds_paramInfo").get(0), rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_reservListChk", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//단순예약 현황 리스트
	@SuppressWarnings("unchecked")
	@RequestMapping("reservList.xdo")
	public ModelAndView reservList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		RecordSet rs = eventMgmt.reservList(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		accessLogService.readLog(parameter.get("ds_paramInfo").get(0), rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_reservList", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//예약 현황 리스트
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rsMst     = eventMgmt.selectListMst(parameter.get("ds_paramInfo").get(0));
		RecordSet rsWedding = eventMgmt.selectListWedding(parameter.get("ds_paramInfo").get(0));
		RecordSet rsGoods   = eventMgmt.selectListGoods(parameter.get("ds_paramInfo").get(0));
		RecordSet rsRoom    = eventMgmt.selectListRoom(parameter.get("ds_paramInfo").get(0));
		RecordSet rsOther   = eventMgmt.selectListOther(parameter.get("ds_paramInfo").get(0));
		RecordSet rsOutSide = eventMgmt.selectListOutSide(parameter.get("ds_paramInfo").get(0));
		RecordSet rsBanquet = eventMgmt.selectListBanquet(parameter.get("ds_paramInfo").get(0));
		
		RecordSet rsPayment = eventMgmt.selectListPayment(parameter.get("ds_paramInfo").get(0));
		
		//첨부파일 검색
		
		String strRefSeq = rsMst.getRecord(0).getString("fileKey");           //첨부파일 참조일련번호를 얻는다.
		@SuppressWarnings("rawtypes")
		List<Map> sampleFileList = attachFileService.selectList(strRefSeq);   //첨부파일 조회 Service 호출
		addOutDataSet (mav, "ds_file", sampleFileList);	//첨부파일 정보  //조회결과를 전달할 DataSet 설정
		
		
		//개인정보보호 접근로그 조회 조건과 건수
		accessLogService.readLog(parameter.get("ds_paramInfo").get(0),  rsMst.size());
 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		
		super.addOutDataSet(mav, "ds_reservMst",    rsMst);
		super.addOutDataSet(mav, "ds_function",     rsWedding);
		super.addOutDataSet(mav, "ds_banquetRoom",  rsBanquet);
		super.addOutDataSet(mav, "ds_goods",        rsGoods);
		super.addOutDataSet(mav, "ds_room",         rsRoom);
		super.addOutDataSet(mav, "ds_other",        rsOther);
		super.addOutDataSet(mav, "ds_outside",      rsOutSide);
		super.addOutDataSet(mav, "ds_approvalList", rsPayment);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	//지불조건만 검색 하는 경우가 있음
	
	@RequestMapping("selectListPayment.xdo")
	public ModelAndView selectListPayment(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		
		Map<String, Object> parameter = xpDTO.getInVariableMap();
		RecordSet rs = eventMgmt.selectListPayment(parameter);
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_approvalList", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	//예약 자료를 저장 한다.
	@RequestMapping("saveData.xdo")
	public ModelAndView saveData(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
				
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"HP_NO, TELNUM, EMAIL, ADDR2"}));		
		
		//저장한다.ds_reservMst  ds_banquetRoom=ds_banquetRoom:U ds_goods=ds_goods:U ds_room=ds_room:U ds_other=ds_other:U ds_outside=ds_outside:U";
		String reservNum =  eventMgmt.saveData(parameter.get("ds_reservMst"),parameter.get("ds_banquetRoom") , parameter.get("ds_goods")   , parameter.get("ds_room"),
				                               parameter.get("ds_other")    ,parameter.get("ds_outside")     , parameter.get("ds_function"), parameter.get("ds_file"),    
				                               loginDTO.getSabun());
		
		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_reservNum",  reservNum);
		                              
		//ModelAndView를 설정한다.      
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//지불조건이 카드인경우 승인및 취소를 저장 하기 위해 SCC_VAN 자료의 초종내역을 읽어 온다.
	@RequestMapping("selectListCardVan.xdo")
	public ModelAndView selectListCardVan(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		
		Map<String, Object> parameter = xpDTO.getInVariableMap();
		RecordSet rs = eventMgmt.selectListCardVan(parameter);
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_payMst", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	//지불조건이 카드인경우
	@SuppressWarnings("unchecked")
	@RequestMapping("saveDataPayment.xdo")
	public ModelAndView saveDataPayment(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {
	          
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//로그인 정보를 반환한다.
		//LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
				
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		 
		//저장한다
		eventMgmt.saveDataPayment(parameter.get("ds_payMst"));
		
	
		
		Map<String, Object> rs = null;
		
		//정상 결제와 취소 결제에 따라 처리 결정
		if("Y".equals(parameter.get("ds_payMst").get(0).get("payCancelYn")))
		 
		{
			rs = eventMgmt.insertDataAdvanceCancel(parameter.get("ds_payMst").get(0));
		
		}else{
			
			rs = eventMgmt.insertDataAdvanceIns(parameter.get("ds_payMst").get(0));
			Map<String, Object> rsPay = eventMgmt.insertDataAdvancePay(parameter.get("ds_payMst").get(0));
			
			
			rs.put("oRtn",     rsPay.get("O_RTN"));
			rs.put("oMessage", rsPay.get("O_MESSAGE"));	
		}
		 
		super.addOutDataSet(mav, "ds_paymentInfo", rs);
 
		                              
		//ModelAndView를 설정한다.      
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
		
		
	}
 
	
}
