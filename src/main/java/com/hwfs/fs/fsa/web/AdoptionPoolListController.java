package com.hwfs.fs.fsa.web;

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
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fs.fsa.service.AdoptionPoolListService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;

 /**
 * 채용인력Pool관리하는 AdoptionPoolList Controller
 * 
 * @ClassName AdoptionPoolListController.java
 * @Description AdoptionPoolListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 yanghj
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsa/adoptionPoolList/")
public class AdoptionPoolListController extends DefaultController {

	/** AdoptionPoolListService Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionPoolListService")
	private AdoptionPoolListService adoptionPoolListService;
	
	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/**
	 * 채용인력Pool관리 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@ValidationToken
    @SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//채용인력Pool관리 을(를) 조회한다.
		RecordSet poolList = adoptionPoolListService.selectList(param.get("ds_search").get(0));
		

		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (poolList.size() > 0) {
			Map map = poolList.get(0);
			Map<String, Object> rowData = poolList.get(0);
			if (rowData.get("fileId") != null)
				strRefSeq =  rowData.get("fileId").toString(); //필드명이 "refSeq"인 경우임
		}
		
		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수 accessLogService.readLog(inVar, rs.size());
		accessLogService.readLog(param.get("ds_search").get(0), poolList.size());
		
		//첨부파일 조회 Service 호출
		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		
		super.addOutDataSet(mav, "dsPoolList", poolList);
		super.addOutDataSet(mav, "dsFile", fileList);	//첨부파일 정보
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 채용인력Pool관리 첨부파일 목록을 조회한다.
	 * <pre>
	 * - 첨부파일 조회하기 (공통)
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("selectFileList.xdo")
	public ModelAndView selectFileList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//채용인력Pool관리 을(를) 조회한다.
		
		String strRefSeq =  LimsUtil.checkNull(param.get("ds_search").get(0).get("fileId"));
		
		//첨부파일 조회 Service 호출
		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsFile", fileList);	//첨부파일 정보
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 채용인력Pool관리 첨부파일 목록을 조회한다.
	 * <pre>
	 * - 첨부파일 조회하기 (공통)
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectSidoCombo.xdo")
	public ModelAndView selectSidoCombo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//채용인력Pool관리 을(를) 조회한다.
		
		RecordSet sidoCombo = adoptionPoolListService.selectSido(param.get("ds_search").get(0));
		
		super.addOutDataSet(mav, "dsSido", sidoCombo);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	
	/**
	 * 채용인력Pool관리(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@ValidationToken
    @SuppressWarnings("unchecked")
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("dsPoolList");
		
		//채용인력Pool관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = adoptionPoolListService.saveList(parameter, param.get("dsFile"), loginDTO);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//채용인력Pool관리 을(를) 조회한다.
		RecordSet poolList = adoptionPoolListService.selectList(param.get("ds_search").get(0));

		//개인정보보호 접근로그를 쌓는다. accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"HP_NO, EMAIL"}));
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"TELNO,HANDPHONE_NUM,ADDR, EMAIL"}));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsPoolList", poolList);
				
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
