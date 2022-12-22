package com.hwfs.fm.fmf.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fmf.service.DayCloseMngtService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 일마감관리하는 DayCloseMngt Controller
 * 
 * @ClassName DayCloseMngtController.java
 * @Description DayCloseMngtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.08    손형민        최초생성
 *  2017.03.29	  kihoon		[CH201703_00751] 미마감내역 조회 팝업 프로그램 개발
 * </pre>
 * @author FC종합전산구축 :  통합영업 손형민
 * @since 2015.06.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmf/dayCloseMngt/")
public class DayCloseMngtController extends DefaultController {
	
	/** DayCloseMngtService Bean 생성 */
	@Resource(name = "/fm/fmf/dayCloseMngtService")
	private DayCloseMngtService dayCloseMngtService;
	
	/**
	 * 일마감관리 목록을 조회한다.
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
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//일마감관리 을(를) 조회한다.
		RecordSet rs = dayCloseMngtService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 일마감관리 목록을 조회한다.(정상분)
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
	@RequestMapping("selectSubList.xdo")
	public ModelAndView selectSubList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//일마감관리 을(를) 조회한다.
		RecordSet rs = dayCloseMngtService.selectSubList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listSub", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 일마감관리 목록을 조회한다.(조정분)
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
	@RequestMapping("selectSubList2.xdo")
	public ModelAndView selectSubList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//일마감관리 을(를) 조회한다.
		RecordSet rs = dayCloseMngtService.selectSubList2(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listSub", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	/**
	 * 일마감관리(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("closing.xdo")
	public ModelAndView closing(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		Map<String, Object> search = param.get("ds_search").get(0);
		search.put("loginSabun", loginDTO.getSabun());
System.out.println("11111111111111111111111111111111111");
		//일마감관리을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> res = dayCloseMngtService.closing(parameter,search);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 0);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		if("TRUE".equals(res.get("O_RTN").toString())){
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, res.get("O_RTNMSG").toString());
		}
	}
	
	/**
	 * 일마감관리(을)를 마감취소 처리한다.
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
	@RequestMapping("cncl.xdo")
	public ModelAndView cncl(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		Map<String, Object> search = param.get("ds_search").get(0);
		search.put("loginSabun", loginDTO.getSabun());

		//일마감관리을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> res = dayCloseMngtService.cncl(parameter,search);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 0);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		if("TRUE".equals(res.get("O_RTN").toString())){
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, res.get("O_RTNMSG").toString());
		}
	}
	
	/**
	 * 일마감관리(을)를 재집계 처리한다.
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
	@RequestMapping("remagam.xdo")
	public ModelAndView remagam(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		Map<String, Object> search = param.get("ds_search").get(0);
		search.put("loginSabun", loginDTO.getSabun());

		//일마감관리을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> res = dayCloseMngtService.remagam(parameter,search);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 0);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		if("TRUE".equals(res.get("O_RTN").toString())){
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, res.get("O_RTNMSG").toString());
		}
	}

	
	/**
	 * 영업회계 일마감관리(을)를 마감취소 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("slaCncl.xdo")
	public ModelAndView slaCncl(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		Map<String, Object> search = param.get("ds_search").get(0);
		search.put("loginSabun", loginDTO.getSabun());

		//일마감관리을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> res = dayCloseMngtService.slaCncl(parameter, search);
		//일마감관리을(를) 등록, 수정, 삭제 처리한다.
		//Map<String, Object> res1 = dayCloseMngtService.cncl(parameter,search);
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 0);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		if("TRUE".equals(res.get("O_RTN").toString())){
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, res.get("O_RTNMSG").toString());
		}
	}
	
	
	/**
	 * 일마감관리 목록을 조회한다.(조정분)
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
	@RequestMapping("selectAllClose.xdo")
	public ModelAndView selectAllClose(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//일마감관리 을(를) 조회한다.
		RecordSet rs = dayCloseMngtService.selectAllClose(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_allYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 미마감내역을 조회한다
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("selectCheckClose.xdo")
	public ModelAndView selectCheckClose(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,HttpServletRequest request) throws Exception {

		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        

		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		parameter.put("loginSabun", loginDTO.getSabun());

		RecordSet rs = dayCloseMngtService.selectCheckClose(parameter);

		super.addOutDataSet(mav, "ds_list", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	@RequestMapping("selectTemp.xdo")
	public ModelAndView selectTemp(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//판매단가 강제변경 을(를) 조회한다.
		RecordSet rs = dayCloseMngtService.selectTemp(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		//super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
		
	
	
}
