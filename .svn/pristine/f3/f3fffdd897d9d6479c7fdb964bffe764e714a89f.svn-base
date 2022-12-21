package com.hwfs.guide.sample.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.service.ComCacheService;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.guide.sample.dto.SampleDTO;
import com.hwfs.guide.sample.dto.SampleSearchDTO;
import com.hwfs.guide.sample.service.SampleService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.service.LoadCacheService;

/**
 * XPLATFORM으로 처리하는 Sample Controller
 * 데이터 입력/수정/삭제, 파일첨부, 다운로드 엑셀 기능 포함
 * 
 * @ClassName XpSampleController.java
 * @Description XpSampleController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 11. 3.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 11. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class XpSampleController extends DefaultController {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
//	@Autowired
//	private ComCacheService cacheService;

//	@Autowired
//	private LoadCacheService loadCacheService;

	@Resource(name = "/guide/sample/sampleService")
	private SampleService sampleService;
	
	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;


	/**
	 * List형태로 데이터를 조회하는 예
	 * <pre>
	 * - 반환되는 데이터의 가능한 형태
	 *   1) RecordSet
	 *   2) List<Map>
	 *   3) List<DTO>
	 * </pre>
	 *
	 * @param xpDTO UI에서 전달되는 통합 Map DTO
	 * @return ModelAndView
	 * @throws Exception
	 */
    @RequestMapping(value="/guide/sample/selectSampleList.xdo")
	public ModelAndView selectSampleList(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
    	//Exception 테스트용
    	//int aa = 10/0;
    	
//    	//Cache 테스트용
//    	String cacheId = "TEST-AA";
//    	String cacheVal;
//    	if(cacheService.contains(cacheId)) {
//    		cacheVal = (String) cacheService.get(cacheId, String.class);
//    	}
//    	else {
//    		cacheVal = "TEST_AA Value";
//    		cacheService.put(cacheId, cacheVal);
//    	}

//    	//캐시관리 테스트
//    	List<CacheInfo> cacheInfoList = cacheService.getCacheInfoList();
//    	List<CacheItemInfo> cacheItemInfoList = cacheService.getCacheItemInfoList();
    	
   	
//    	//RequestContext 테스트: ThredLocal
//    	logger.debug("usrid={}", RequestContextUtil.get(DefaultConsts.THREAD_LOCAL_USERID_NAME));
//    	logger.debug("sabun={}", RequestContextUtil.get(DefaultConsts.THREAD_LOCAL_SABUN_NAME));
    	
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> searchMap = xpDTO.getInVariableMap();
		
		//1)RecordSet으로 반환하는 경우
		RecordSet list = sampleService.selectSampleList(searchMap);
		
		//2)List<Map>으로 반환하는 경우
		//List<Map> list = sampleService.selectSampleListMap(searchMap);

		//3)List<DTO>으로 반환하는 경우
		//List<SampleDTO> list = sampleService.selectSampleListDTO(searchDTO);

		//건수조회
		int totalCount =  sampleService.selectSampleCount(searchMap);
		
		//결과 데이터셋 설정
		addOutDataSet (mav, "ds_output", list);

		//결과 Variable 설정
		addOutVariable(mav, "outVarCnt", totalCount);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
    } 

	/**
	 * Page 단위 List형태로 데이터를 조회하는 예 --> 미정리
	 * <pre>
	 * - 반환되는 데이터의 가능한 형태
	 *   1) RecordSet
	 *   2) List<Map>
	 *   3) List<DTO>
	 * </pre>
	 *
	 * @param xpDTO UI에서 전달되는 통합 Map DTO
	 * @return ModelAndView
	 * @throws Exception
	 */
    @RequestMapping(value="/guide/sample/selectSampleListPage.xdo")
    public ModelAndView selectSampleListPage(@ModelAttribute("searchDTO") SampleSearchDTO searchDTO) throws Exception {
    	//Exception 테스트용
    	//int aa = 10/0;

//    	/** EgovPropertyService.sample */
//    	searchDTO.setPageUnit(propertiesService.getInt("pageUnit"));
//    	searchDTO.setPageSize(propertiesService.getInt("pageSize"));
//    	
//    	/** paging setting */
		//페이지 파라미터 바인딩
		searchDTO.setFirstIndex (( searchDTO.getPageIndex() - 1 ) * searchDTO.getRecordCountPerPage() );
		
//    	PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(searchDTO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(searchDTO.getPageUnit());
//		paginationInfo.setPageSize(searchDTO.getPageSize());
//		
//		searchDTO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		searchDTO.setLastIndex(paginationInfo.getLastRecordIndex());
//		searchDTO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
//		SearchParameters searchParams = new SearchParameters();
//		searchParams.put("searchCondition", searchDTO.getSearchCondition());
//		searchParams.put("searchKeyword", searchDTO.getSearchKeyword());
		
        //RecordSet rs = sampleService.selectSampleListPage(searchParams);

		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();

		RecordSet rs = sampleService.selectSampleListPage(searchDTO);
        
//        int totCnt = sampleService.selectSampleListTotCnt(searchDTO);
//		paginationInfo.setTotalRecordCount(totCnt);
//        model.addAttribute("paginationInfo", paginationInfo);
        
		//결과 데이터셋 설정
		addOutDataSet (mav, "ds_output", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
    } 

    /**
     * Grid 데이터를 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - Map으로 데이터 바인딩
     * - Insert/Update/Delete 별로 분리하여 데이터 바인딩
     * </pre>
     *
     * @param xpDTO UI에서 전달되는 통합 Map DTO
     * @param request HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
	@RequestMapping("/guide/sample/saveSample.xdo")
	public ModelAndView saveSample (
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  , HttpServletRequest request) throws Exception	
	{
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
//		//로그인 세션 정보 얻기 : CUSER, UUSER를 hqml로 전달은 프레임워크에서 처리하므로 로그인 세션을 얻을 필요 없다. 
//		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
//		logger.debug("*****loginVO.idUser={}", loginDTO.getSabun());

		//저장할 데이터를 얻는다. 데이터셋 단위로 얻는다.
		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();
		DataSetMap list = (DataSetMap) inDataset.get("ds_input");
		
		//데이터 처리 서비스 호출 : inDataset을 전달하기보다는 DataSetMap 단위로 전달한다.
		//1)rowType 건별로 루프를 돌며 처리하는 방식
		//int totalCnt = sampleService.saveSample(list);
		
		//2)rowType 그룹별로 처리하는 방식 (배치 처리에 유용)
		int totalCnt = sampleService.saveSample2(list);
		
		//결과 Variable 설정 : 결과 Variable를 전달하는 예로 업무에 따라 설정 
		addOutVariable(mav, "outVarCnt", totalCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}

    /**
     * Grid 데이터를 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - Insert/Update/Delete 별로 분리하여 데이터 바인딩
     * - DTO로 데이터 바인딩
     * </pre>
     *
     * @param listIns Insert List
     * @param listUpd Update List
     * @param listDel Delete List
     * @param request HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
	@RequestMapping("/guide/sample/saveSampleDTO.xdo")
	public ModelAndView saveSampleDTO (
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  , @Bind(id="ds_input:ins", type=SampleDTO.class)List<SampleDTO> listIns
		  , @Bind(id="ds_input:upd", type=SampleDTO.class)List<SampleDTO> listUpd
		  , @Bind(id="ds_input:del", type=SampleDTO.class)List<SampleDTO> listDel			
		  , @Bind(id="ds_input", type=SampleDTO.class)List<SampleDTO> listAll
		  , @Bind(id="ds_input"	 , type=DataSetMap.class)DataSetMap dsList
		  , @Bind(id="var") Map paramMap 									//Parameter를 받을 경우
		  , HttpServletRequest request) throws Exception	
	{
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
		//데이터 처리 서비스 호출
		int totalCnt = sampleService.saveSample(listIns, listUpd, listDel);
		
		//결과 Variable 설정 : 결과 Variable를 전달하는 예로 업무에 따라 설정 
		addOutVariable(mav, "outVarCnt", totalCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}


	/**
	 * 단일 건과 첨부파일 select 문이 수행되는 서비스이다.
	 * @param xpDTO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/guide/sample/selectSampleAttachFile.xdo")
	public ModelAndView selectSampleAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//데이터 조회 Service 호출
		RecordSet sampleList = sampleService.selectSampleList(inVar);
		
		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (sampleList.size() > 0) {
			Map map = sampleList.get(0);
			if (map.get("refSeq") != null)
				//lngSeqRel =  Long.parseLong(map.get("seqRel").toString()); //필드명이 "seqRel"인 경우임
				strRefSeq =  map.get("refSeq").toString(); //필드명이 "refSeq"인 경우임
		}
		
		//첨부파일 조회 Service 호출
		List<Map> sampleFileList = attachFileService.selectList(strRefSeq);
		
		//조회결과를 전달할 DataSet 설정
		addOutDataSet (mav, "ds_output", sampleList);		//데이터
		addOutDataSet (mav, "ds_file", sampleFileList);	//첨부파일 정보
		
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
	@RequestMapping(value = "/guide/sample/saveSampleAttachFile.xdo")
	public ModelAndView saveSampleAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  ,	HttpServletRequest req) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();
		
		//Service호출에 전달할 DataSetMap을 얻는다.
		DataSetMap list = (DataSetMap) inDataset.get("ds_input");		//데이터
		DataSetMap listFile = (DataSetMap) inDataset.get("ds_file");	//첨부파일 정보

		//로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//서비스 호출 후 첨부참조일련번호가 반환된다.
		String strRefSeq = sampleService.saveSampleAttachFile(list, listFile, loginDTO);
		
		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		addOutVariable(mav, "outVarRefSeq", strRefSeq);
		
		//(중요)첨부파일정보가 바뀌므로 재조회 하여 클라이언트에 전달한다.
		//첨부파일 조회 Service 호출
		if (!strRefSeq.equals("")) {
			List<Map> sampleFileList = attachFileService.selectList(strRefSeq);
			addOutDataSet (mav, "ds_file", sampleFileList);
		}
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
	}

    /**
     * Blob 데이터를 Insert/Update/Delete 처리하는 샘플
     * <pre>
     * - Map으로 데이터 바인딩
     * - Insert/Update/Delete 별로 분리하여 데이터 바인딩
     * </pre>
     *
     * @param xpDTO UI에서 전달되는 통합 Map DTO
     * @param request HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
	@RequestMapping("/guide/sample/saveBlobSample.xdo")
	public ModelAndView saveBlobSample (
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  , HttpServletRequest request) throws Exception	
	{
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
//		//로그인 세션 정보 얻기 : CUSER, UUSER를 hqml로 전달은 프레임워크에서 처리하므로 로그인 세션을 얻을 필요 없다. 
//		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
//		logger.debug("*****loginVO.idUser={}", loginDTO.getSabun());

		//저장할 데이터를 얻는다. 데이터셋 단위로 얻는다.
		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();
		DataSetMap list = (DataSetMap) inDataset.get("ds_input");
		
		//blob test : blob 칼럼을 파일로 저장하는 예이며, 실제로는 테이블의 BLOB 칼럼으로 저장하면 된다.
		int totalCnt = list.size();
		byte[] blob = (byte[])list.get(0).get("blob");
		
		saveBlobToFile("d:/aaa.jpg", blob);
		
		//결과 Variable 설정 : 결과 Variable를 전달하는 예로 업무에 따라 설정 
		addOutVariable(mav, "outVarCnt", totalCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}

    private void saveBlobToFile(String srcFile, byte[] bytBuf) throws Exception {
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(new File(srcFile));
            int i = 0;
            if (fos != null) {
            	fos.write(bytBuf, 0, bytBuf.length);
            }

        } catch (Exception ex) {
        	logger.error(ex.getLocalizedMessage());
        } finally {
        	if (fos != null){
                try {
                    fos.close();
                } catch (Exception e) {
                    logger.error(e.getLocalizedMessage());
                    logger.error("error at saveBlobToFile", e);
                }
            }
        }
    }

}
