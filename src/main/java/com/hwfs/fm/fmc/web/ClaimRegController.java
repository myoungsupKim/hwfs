package com.hwfs.fm.fmc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.fm.fmc.service.ClaimRegService;
import com.hwfs.sc.cmn.dto.AttachFileDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.util.StringUtil;


 /**
 * 클레임요청하는 ClaimReg Controller
 * 
 * @ClassName ClaimRegController.java
 * @Description ClaimRegController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    최영준        최초생성
 *  2015.07.13	  손형민		인수인계
 *  2021.08.09    DEV02         [PJT]주문채널통합
 * </pre>
 * @author FC종합전산구축 :  통합영업 최영준
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmc/claimReg/")
public class ClaimRegController extends DefaultController {
	
    
	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/** ClaimRegService Bean 생성 */
	@Resource(name = "/fm/fmc/claimRegService")
	private ClaimRegService claimRegService;
	
	

	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubinv.xdo")
	public ModelAndView selectSubinv(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//선택한 업장에 대한 창고리스트를 가져온다
		RecordSet rs = claimRegService.selectSubinv(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_subinv", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 클레임요청 목록을 조회한다.
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

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//클레임요청 을(를) 조회한다.
		RecordSet rs = claimRegService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 클레임요청 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 *   [PJT]주문채널통합
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectBrandList.xdo")
	public ModelAndView selectBrandList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//클레임요청 을(를) 조회한다.
		RecordSet rs = claimRegService.selectBrandList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 공통코드 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("commonList.xdo")
	public ModelAndView commonList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//공통코드 목록을 조회한다.
		RecordSet rs = claimRegService.commonList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_common", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 클레임요청(을)를 Insert/Update/Delete 처리한다.
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
		DataSetMap parameter = param.get("ds_list");

		//클레임요청을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = claimRegService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * DataSet의 rowType별로 Insert, Update, Delete가 수행되는 서비스이다.
	 * <pre>
	 * -데이터와 첨부파일을 함께 처리한다.
	 * -첨부파일은 파일 저장소에 저장한다.
	 * </pre>
	 *
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	//@ValidationToken
	@RequestMapping(value = "saveAttachFile.xdo")
	public ModelAndView saveSampleAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  ,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();

		//Service호출에 전달할 DataSetMap을 얻는다.
		DataSetMap list = (DataSetMap) inDataset.get("ds_list");		//데이터
		DataSetMap listFile = (DataSetMap) inDataset.get("ds_file");	//첨부파일 정보

		//로그인 세션 정보 얻기
		//LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//서비스 호출 후 첨부참조일련번호가 반환된다.
		String strRefSeq = claimRegService.saveAttachFile(list, listFile);

		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		addOutVariable(mav, "fv_RefSeq", strRefSeq);

		//(중요)첨부파일정보가 바뀌므로 재조회 하여 클라이언트에 전달한다.
		//첨부파일 조회 Service 호출
		if (!strRefSeq.equals("")) {
			List<Map> fileList = attachFileService.selectList(strRefSeq);
			addOutDataSet (mav, "ds_file", fileList);
		}

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * DataSet의 rowType별로 Insert, Update, Delete가 수행되는 서비스이다.
	 * <pre>
	 * -데이터와 첨부파일을 함께 처리한다.
	 * -첨부파일은 파일 저장소에 저장한다.
	 * </pre>
	 *
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	//@ValidationToken
	@RequestMapping(value = "saveAttachFileCopy.xdo")
	public ModelAndView saveSampleAttachFileCopy(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  ,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();
		
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		String seq = (String)inVar.get("seq"); // 첨부일련번호

		//Service호출에 전달할 DataSetMap을 얻는다.
		DataSetMap listFile = (DataSetMap) inDataset.get("ds_file");	//첨부파일 정보
		DataSetMap list = (DataSetMap) inDataset.get("ds_list");	//첨부파일 정보

		//서비스 호출 후 첨부참조일련번호가 반환된다.
		String strRefSeq = claimRegService.save(listFile, propertiesService.getString("fm.file.path"), false, true, false, seq);
		if(seq.equals("") || seq.equals("undefined")){
			claimRegService.saveFileId(list,strRefSeq);
		}

		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		addOutVariable(mav, "fv_RefSeq", strRefSeq);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * PC사진 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPC.xdo")
	public ModelAndView selectPC(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//공통코드 목록을 조회한다.
		RecordSet list = claimRegService.selectPC(inVar);
		
		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (list.size() > 0) {
			Map map = list.get(0);
			if (map.get("fileId") != null)
				strRefSeq =  map.get("fileId").toString(); //필드명이 "refSeq"인 경우임
		}

		//첨부파일 조회 Service 호출
		List<Map> pcFileList = attachFileService.selectList(strRefSeq);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", list);
		super.addOutDataSet(mav, "ds_file", pcFileList);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * Mobile사진 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectMobile.xdo")
	public ModelAndView selectMobile(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//공통코드 목록을 조회한다.
		RecordSet list = claimRegService.selectMobile(inVar);
		
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_file", list);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 자재별 재고량 확인.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectItemQty.xdo")
	public ModelAndView selectItemQty(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		DataSetMap list = (DataSetMap) param.get("ds_list");		//데이터
		//선택한 업장에 대한 창고리스트를 가져온다
		Map <String, Object> rs = claimRegService.ItemQty(list);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		if(rs != null && rs.size() > 0 && "N".equals(rs.get("claimQty"))){
			String msg = "["+rs.get("upjangNm")+"]업장의 ["+rs.get("itemName")+"]자재는\n재고부족으로 클레임 요청을 하실 수 없습니다.";
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, msg);
		}
		super.addOutVariable(mav, "fv_processCnt", 0);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		
	}
	

}
