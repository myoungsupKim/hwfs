package com.hwfs.ls.ltm.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lrm.dao.TestInfoRegDAO;
import com.hwfs.ls.lrm.service.TestRegInqueryService;
import com.hwfs.ls.ltm.dao.TestResultInqueryDAO;
import com.hwfs.sc.cmn.dao.AttachFileDAO;
import com.hwfs.sc.cmn.util.FileUtil;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 시험진행 및 결과 조회 ServiceImple Class
 *
 * @ClassName TestResultInqueryServiceImple.java
 * @Description TestResultInqueryServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 27.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 27.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/ltm/testResultInqueryService")
public class TestResultInqueryServiceImpl extends DefaultServiceImpl implements TestResultInqueryService {

    /** AttachFile Service Bean 생성 */
    /*@Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;*/

    /** AttachFileDAO */
    @Resource(name = "/sc/cmn/attachFileDAO")
    private AttachFileDAO attachFileDAO;

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

    /** File Attach DB Sequence idGnrService */
    @Resource(name = "idGenSequenceAtchFile")
    private SequenceIdGenService idGenSequenceAtchFile;

    @Resource(name = "/ls/ltm/testResultInqueryDAO")
    private TestResultInqueryDAO testResultInqueryDAO;

    @Resource(name = "/ls/lrm/testRegInqueryService")
    private TestRegInqueryService testRegInqueryService;

    @Resource(name = "/ls/lrm/testInfoRegDAO")
    private TestInfoRegDAO testInfoRegDAO;

    /**
     * 의뢰목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectList(parameter);
    }

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectSpecmList(java.util.Map)
    */
    @Override
    public RecordSet selectSpecmList(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectSpecmList(parameter);
    }

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectDetailList(parameter);
    }

    /**
     * 시험일지 데이터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectTestDiary(java.util.Map)
    */
    @Override
    public RecordSet selectTestDiary(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectTestDiary(parameter);
    }

    /**
     * 시험일지 시험방법 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectTestDiaryMethodList(java.util.Map)
    */
    @Override
    public RecordSet selectTestDiaryMethodList(Map<String, Object> parameter) throws Exception {
        RecordSet rs = testResultInqueryDAO.selectTestDiaryMethodList(parameter);
        if (rs.isEmpty()) {
            // 첫 시험일지 작성 시 시험항목의 시험방법을 가져와서 보여준다.
            rs = testResultInqueryDAO.selectTestDiaryMethodArticleList(parameter);
        }
        return rs;
    }

    /**
     * 시험일지를 저장한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#saveList(java.util.Map, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(Map<String, Object> param, DataSetMap testArticleList, DataSetMap testDiaryList,
            DataSetMap listFile) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        int iCnt = 0;

        String strRefSeq = ""; //첨부참조일련번호
        //strRefSeq = attachFileService.save(listFile, propertiesService.getString("ls.file.path"), false);
        //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
        if (listFile.size() > 0) {
            strRefSeq = save(listFile, propertiesService.getString("ls.file.path"), false);
        }

        for (int i = 0; i < testArticleList.size(); i++) {
            parameter = testArticleList.get(i);
            parameter.put("reqNum", LimsUtil.checkNull(param.get("reqNum")));
            parameter.put("acceptNum", LimsUtil.checkNull(param.get("acceptNum")));
            parameter.put("articleCd", LimsUtil.checkNull(param.get("articleCd")));
            parameter.put("sabun", LimsUtil.checkNull(param.get("sabun")));
            if (!"".equals(strRefSeq))
                parameter.put("refSeq", strRefSeq);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            // 작업일지 건수가 0인경우, 1개라도 있으면 Skip
            iCnt = testResultInqueryDAO.selectTestDiaryCnt(parameter);
            if (iCnt == 0) {
                param.put("procClass", "160"); // 시험진행중
                procCnt += testRegInqueryService.saveStatus(param);
                testInfoRegDAO.insertProcDesc(param); // 처리내역 저장
            }

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                procCnt += testResultInqueryDAO.updateTestArticleList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += testResultInqueryDAO.updateTestArticleList(parameter);
            }
        }

        // 시험방법 삭제 후 저장
        procCnt += testResultInqueryDAO.deleteAllTestDiaryList(param);
        for (int i = 0; i < testDiaryList.size(); i++) {
            parameter = testDiaryList.get(i);
            parameter.put("reqNum", LimsUtil.checkNull(param.get("reqNum")));
            parameter.put("acceptNum", LimsUtil.checkNull(param.get("acceptNum")));
            parameter.put("articleCd", LimsUtil.checkNull(param.get("articleCd")));
            parameter.put("sabun", LimsUtil.checkNull(param.get("sabun")));
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                procCnt += testResultInqueryDAO.insertTestDiaryList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += testResultInqueryDAO.updateTestDiaryList(parameter);
                //} else if (rowType == DataSet.ROW_TYPE_DELETED) {
                //procCnt += testResultInqueryDAO.deleteTestDiaryList(parameter);
            }
        }

        // 모든시험항목과 최종판정 건수가 동일하면 자동 시험완료승인중으로 처리한다.
        String strDiaryEndYn = testResultInqueryDAO.selectTestDiaryEndYn(parameter);
        if ("Y".equals(strDiaryEndYn)) {
            Map<String, Object> procStatus = testResultInqueryDAO.selectLastProgressStatus(parameter).get(0);
            // 최종 진행상태가 시험완료승인중 체크
            if (!LimsUtil.checkNull(procStatus.get("procClass")).equals("180")) {
                param.put("procClass", "180"); // 시험완료승인중
                procCnt += testRegInqueryService.saveStatus(param);
                testInfoRegDAO.insertProcDesc(param); // 처리내역 저장
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("strRefSeq", strRefSeq);

        return retVal;
    }

    /**
     * 시험결과 상신 전 검사목적,방법을 등록한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#saveList(java.util.Map, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveInsptPurpMtod(Map<String, Object> param) throws Exception {
        int procCnt = 0;

        // 시험결과 구매전송일 경우
        if (LimsUtil.checkNull(param.get("draftGubun")).equals("5")) {
            procCnt += testResultInqueryDAO.saveInsptPurpMtodItemSend(param);
        } else {
            procCnt += testResultInqueryDAO.saveInsptPurpMtod(param);
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 시험결과 상신 Master를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectTestDiaryMethodList(java.util.Map)
    */
    @Override
    public Record selectReportMst(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectReportMst(parameter);
    }

    /**
     * 시험결과 상신 Detail를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectReportDetail(java.util.Map)
    */
    @Override
    public RecordSet selectReportDetail(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectReportDetail(parameter);
    }

    /**
     * 검체폐기 정보를 등록한다.
     *
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#saveDisuseYn(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveDisuseYn(DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            procCnt += testResultInqueryDAO.saveDisuseYn(parameter);
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 성적서 발급여부를 변경.
     *
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#saveInspectRptIssueYn(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveInspectRptIssueYn(DataSetMap saveList) throws Exception {
        int procCnt = 0;
        int rowType = 0;
        Map<String, Object> parameter = null;

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += testResultInqueryDAO.saveInspectRptIssueYn(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 검체 폐기대상 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectSpecmDisuseList(java.util.Map)
    */
    @Override
    public RecordSet selectSpecmDisuseList(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectSpecmDisuseList(parameter);
    }

    /**
     * 검체폐기 정보를 일괄 등록한다.
     *
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#saveDisuseAllYn(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveDisuseAllYn(DataSetMap saveList) throws Exception {
        int procCnt = 0;
        int rowType = 0;
        String strChk = "0";
        Map<String, Object> parameter = null;

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    procCnt += testResultInqueryDAO.saveDisuseAllYn(parameter);
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 서버 사진을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    @Override
    public RecordSet selectImgList(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectImgList(parameter);
    }

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 global.filerepository.path가 된다.
     * </pre>
     *
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미)
     * @throws Exception
     */
    public String save(DataSetMap listFile, String relPath, boolean encYn) throws Exception {
        return save(listFile, relPath, encYn, false, false);
    }

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다.
     * - useOrgnlNmYn가 true이면 원본 파일명을 유지
     * </pre>
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @param webRepoYn 파일저장소를 webapp 아래로 할지 여부(true이면 global.imagerepository.path 아래로 저장)
     * @param useOrgnlNmYn 파일저장 시 원본 파일명을 유지할지 여부 (보안에 문제가 없는 파일인 경우만 원본명 유지 가능)
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn)
            throws Exception {

        String strRefSeq = ""; //첨부일련번호

        // 첨부일련번호를 얻는다.
        for (int i = 0; i < listFile.size(); i++) {
            Map<String, Object> map = listFile.get(i);
            int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType != DataSet.ROW_TYPE_INSERTED) { //ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_DELETED){
                strRefSeq = map.get("refSeq").toString(); //Long.parseLong(map.get("refSeq").toString());
                break;
            }
        }
        // 첨부일련번호를 새로 채번하는 경우 처리
        if (strRefSeq.equals(""))
            strRefSeq = idGenSequenceAtchFile.getNextStringId();

        int intCnt = 0; // 파일 처리 건수

        // 먼저 첨부파일 처리
        for (int i = 0; i < listFile.size(); i++) {
            Map<String, Object> map = listFile.get(i);

            int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                // 첨부일련번호 설정
                map.put("refSeq", strRefSeq);

                // 저장시 원본파일명 유지 여부에 따라 처리
                if (!useOrgnlNmYn) {
                    // 저장파일명 설정 - UUID 적용 및 시간표시
                    if (propertiesService.getBoolean("global.fileupload.appendTime"))
                        map.put("saveFileNm", idGenUUIdService.getNextStringHostId() + "-" + DateUtil.getYyyymmddhhmmss());
                    else
                        map.put("saveFileNm", idGenUUIdService.getNextStringHostId());
                } else {
                    map.put("saveFileNm", DateUtil.getYyyymmddhhmmss() + "-" + map.get("orgnlFileNm"));
                }
                // 저장상대패스 설정
                map.put("relPath", relPath);

                // 파일암호화 여부
                map.put("encYn", encYn ? "Y" : "N");

                // DAO 호출
                intCnt += attachFileDAO.insert(map);

                // 파일저장소로 복사
                String sourceFile = propertiesService.getString("global.fileupload.path") + "/" + map.get("fileUploadNm");
                String targetFile;
                if (webRepoYn)
                    targetFile = propertiesService.getString("global.imagerepository.path") + relPath + "/"
                            + map.get("saveFileNm");
                else
                    targetFile = propertiesService.getString("global.filerepository.path") + relPath + "/"
                            + map.get("saveFileNm");

                // -파일암호화 처리
                if (encYn) {
                    String encFile = sourceFile + "_enc";
                    cryptoService.encryptFile(sourceFile, encFile);
                    sourceFile = encFile;
                }

                boolean isCopied = false;

                // 모바일 서버 사진 선택이 존재한다.
                if (!"".equals(LimsUtil.checkNull(map.get("preView")))) {
                    String dirFrom = propertiesService.getString("global.imagerepository.path") + "/"
                            + propertiesService.getString("ms.file.path");
                    String preView = LimsUtil.checkNull(map.get("preView").toString());
                    File preFile = new File(dirFrom + preView);
                    // 파일 이동처리
                    FileUtils.copyFile(preFile, new File(targetFile));
                    if (preFile.isFile()) {
                        isCopied = true;
                    }
                } else {
                    // 파일 이동처리
                    isCopied = FileUtil.copyFile(sourceFile, targetFile);
                }

                if (!isCopied)
                    throw super.processException("fail.uploadfile.not.found");

            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                intCnt += attachFileDAO.update(map);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {
                intCnt += attachFileDAO.delete(map);
                // 파일저장소 파일 삭제
                String targetFile;
                if (webRepoYn)
                    targetFile = propertiesService.getString("global.imagerepository.path") + map.get("relPath") + "/"
                            + map.get("saveFileNm");
                else
                    targetFile = propertiesService.getString("global.filerepository.path") + map.get("relPath") + "/"
                            + map.get("saveFileNm");
                FileUtil.deleteFile(targetFile);
            }
        }

        // 새로 채번된 참조일련번호 (-1 이면 변경되지 않음을 의미)
        if (intCnt == 0)
            return "";
        else
            return strRefSeq;
    }
    
    /**
     * 구매 수기 등록 저장한다.
     *
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#saveDisuseYn(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> insertSendItem(DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            procCnt += testResultInqueryDAO.insertSendItem(parameter);
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 결재상신팝업 저장내역 조회
     *
     * @param map
     * @return
     * @since 20171123
     * @author 유선미
     */
    @Override
    public RecordSet selectGwDraftTemp(Map<String, Object> parameter) throws Exception {
        return testResultInqueryDAO.selectGwDraftTemp(parameter);
    }

    /**
     * 결재상신 팝업 임시저장
     *
     * @param parameter
     * @return
     * @throws Exception
     * @since 20171123
     * @author 유선미
     */
    public int saveGwDraftTemp( Map<String, Object> param) throws Exception{
        return testResultInqueryDAO.saveGwDraftTemp(param);
    }

    /**
     * 시험진행및결과조회 시험목록을 저장한다.
     *
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#saveResultList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveResultList(DataSetMap resultList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        int iCnt = 0;
        String strRefSeq = ""; //첨부참조일련번호

        for (int i = 0; i < resultList.size(); i++) {
            parameter = resultList.get(i);
            
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            
            // 작업일지 건수가 0인경우, 1개라도 있으면 Skip
            iCnt = testResultInqueryDAO.selectTestDiaryCnt(parameter);
            if (iCnt == 0) {
            	parameter.put("procClass", "160"); // 시험진행중
                procCnt += testRegInqueryService.saveStatus(parameter);
                testInfoRegDAO.insertProcDesc(parameter); // 처리내역 저장
            }

            // 시험항목 기준규격 변경
            procCnt += testResultInqueryDAO.updateBasisStand(parameter);
            
            parameter.put("refSeq", strRefSeq);
            // 시험일지마스터(LTM_TEST_DIARY) 반영
            procCnt += testResultInqueryDAO.updateTestArticleList(parameter);   

            // 시험방법 삭제 후 저장
            parameter.put("testMethod",LimsUtil.checkNull(parameter.get("testMtod"))); //시험방식
            procCnt += testResultInqueryDAO.deleteAllTestDiaryList(parameter);
            procCnt += testResultInqueryDAO.insertTestDiaryList(parameter);
        }

        // 모든시험항목(LRM_TEST_INFO)에 대해 최종판정(LTM_TEST_DIARY)이 되었으면 자동 시험완료승인중으로 처리한다.
        String strDiaryEndYn = testResultInqueryDAO.selectTestDiaryEndYn(parameter);
        if ("Y".equals(strDiaryEndYn)) {
            Map<String, Object> procStatus = testResultInqueryDAO.selectLastProgressStatus(parameter).get(0);
            // 최종 진행상태가 시험완료승인중 체크
            if (!LimsUtil.checkNull(procStatus.get("procClass")).equals("180")) {
            	parameter.put("procClass", "180"); // 시험완료승인중
                procCnt += testRegInqueryService.saveStatus(parameter);
                testInfoRegDAO.insertProcDesc(parameter); // 처리내역 저장
            }
        }
        
        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("procClass", parameter.get("procClass"));

        return retVal;
    }

}


