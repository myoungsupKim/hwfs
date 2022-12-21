package com.hwfs.rc.bms.web;

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
import com.hwfs.rc.bms.service.EventEndMgmtService;

 /**
 * EventEndMgmtController에 대한 설명 작성
 * @ClassName EventEndMgmtController.java
 * @Description EventEndMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 21.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/bms/eventEndMgmt/")
public class EventEndMgmtController extends DefaultController {
	@Resource(name="/rc/bms/eventEndMgmtService")
	private EventEndMgmtService eventEndMgmt;
	
	//단순예약 현황 리스트
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		RecordSet rs = eventEndMgmt.selectList(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		accessLogService.readLog(parameter.get("ds_paramInfo").get(0), rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_reservList", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectListMst.xdo")
	public ModelAndView selectListMst(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		RecordSet rs = eventEndMgmt.selectListMst(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		accessLogService.readLog(parameter.get("ds_paramInfo").get(0), rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_reservMst", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectListEndEvent.xdo")
	public ModelAndView selectListEndEvent(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		RecordSet rs = eventEndMgmt.selectListEndEvent(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		accessLogService.readLog(parameter.get("ds_paramInfo").get(0), rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_eventEndList", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	@RequestMapping("saveData.xdo")
	public ModelAndView saveData(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//로그인 정보를 반환한다.
		//LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
				
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		//accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"HP_NO, TELNUM, EMAIL, ADDR2"}));		
		
		//저장한다.ds_reservMst  ds_banquetRoom=ds_banquetRoom:U ds_goods=ds_goods:U ds_room=ds_room:U ds_other=ds_other:U ds_outside=ds_outside:U";
		int procCnt  =  eventEndMgmt.saveData(parameter.get("ds_reservMst"));
		
		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
}
