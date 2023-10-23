REM ******************************************************************************************************************************************
REM SCRIPT 용도 : 결제 데이터를 만들기 위한 프로시저 
REM 작성자 : 최경민
REM 작성일 : 2023-09-14, Version 1
REM 수정일 : 2023-09-14, Version 1
REM         2023-09-15, Version 1.1
REM        
REM 주의사항 : 
REM 수정사항 : 2023-09-15 최경민 결제 프로시저 결제 혜택 적용해서 들어감 확인
REM           2023-09-15 최경민 결제 프로시저가 한달만 따지고 한달뒤엔 다시 초기화해서 혜택 들어가도록 시간 적용
REM           2023-09-15 최경민 결제할 카드 PICK 프로시저 시작 version1 , 혜택 들어간 price는 나오지만 card_id가 제대로 pick 안됨 문제 발생
REM           2023-09-16 최경민 결제할 카드 pick 프로시저 중 거래내역에서 혜택 현황 조회쪽 쿼리 수정(card_id를 조건에 추가- 해당 유저의 특정 카드를 조회하게끔),
REM           2023-09-16 최경민 결제할 카드 pick 프로시저 중 price list에 넣는 쿼리를 loop문에 넣는 위치 수정해서 15일의 문제 해결
REM           2023-09-19 최경민 결제할 카드 pick 프로시저 중 혜택이 없을 경우 실적관리 시작 (예외처리 문제있음)
REM           2023-09-20 최경민 결제할 카드 pick 프로시저 중 혜택이 없을 경우 실적이 가장 남지 않은 카드 추천해줌 
REM           2023-10-03 최경민 결제할 카드 pick 프로시저 중 혜택이 없을 경우 업종으로 한번더 찾아줌
REM           2023-10-08 최경민 결제할 카드 pick 프로시저 맨 첫번째 쿼리 실행 안되고 있었음. p_storename이 매개변수가 아닌 문자열로 인식되고 있었음
REM           2023-10-08 최경민 INSTR('p_storename', b.benefit_store_name) > 0  -> INSTR(p_storename, b.benefit_store_name) > 0
REM           2023-10-08 최경민 결제할 카드 pick 프로시저에서 혜택 DTO 추가 정보 얻는 로직에서 가게명 조건이 있는데 국내음식점일 경우는 찾아지지 않는다 (또 예외처리 추가해보자)
REM                                         BEGIN 안에 BEGIN을 넣어 중첩으로 예외처리 추가함
REM                                         결론 : 혜택 찾기를 매장으로 한번 그 후 음식점일 경우 음식점으로 한번더 찾는다
REM                                         결제할 카드 pick 프로시저에서 한도가 금액일 경우를 따져서 pick 하는 로직 추가함
REM ********************************************************************************************************************************************************
SET SERVEROUTPUT ON
update membercard set last_month_total = 500000 where card_number = 4203754097906696;
commit;
select * from membercard;
select * from transactionhistory;
--두개의 프로시저 같이 실행 (혜택 많은 카드 pick 후에 결제)
-- SP_PICK_CARD 프로시저 호출
select * from transactionhistory order by transaction_id;
DECLARE
   p_date transactionhistory.transaction_date%TYPE := '20221014';
   p_member_id varchar2(20) := 'user001'; 
   p_storeName VARCHAR2(255) := '스타벅스 철산점'; 
   p_price number := 14200;
   p_storeCategoryCode VARCHAR2(20) := 'CE'; 
   v_card_id card.card_id%type; -- OUT 파라미터
BEGIN
   SP_PICK_CARD(p_date,p_member_id, p_storeName, p_price, p_storeCategoryCode, v_card_id);
   -- v_card_id를 사용하여 SP_SUBMIT_PAYMENT를 호출합니다.
   
   -- SP_SUBMIT_PAYMENT 프로시저 호출
   DECLARE
     v_transaction_id transactionhistory.transaction_id%type;
   BEGIN
     SP_SUBMIT_PAYMENT(
       p_date => p_date,
       p_member_id => p_member_id, -- 위에서 선언한 값을 그대로 사용
       p_card_id => v_card_id,    -- v_card_id 값을 사용합니다.
       p_storeName => p_storeName,  -- 위에서 선언한 값을 그대로 사용
       p_price => p_price,        -- 위에서 선언한 값을 그대로 사용
       p_storeCategoryCode => p_storeCategoryCode,  -- 위에서 선언한 값을 그대로 사용
       OUT_TRANSACTION_ID => v_transaction_id
     );
     COMMIT; 
     DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_transaction_id);
   END;
END;
/
delete from transactionhistory;
commit;
select * from transactionhistory;

desc transactionhistory;
--결제 프로시저 실행  
DECLARE
  v_transaction_id transactionhistory.transaction_id%type;
BEGIN
  SP_SUBMIT_PAYMENT(
    p_date => '20220920',
    p_member_id => 'user001',
    p_card_id => '1',
    p_storeName => 'GS슈퍼 ',
    p_price => 6400,
    p_storeCategoryCode => 'CE',
    OUT_TRANSACTION_ID => v_transaction_id
  );
  COMMIT; 
  DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_transaction_id);
END;
/
SET SERVEROUTPUT ON
/

-- 카드 pick 프로시저 실행 
DECLARE
   p_date transactionhistory.transaction_date%TYPE := '20221006';
   p_member_id varchar2(20) := 'user001'; 
   p_storeName VARCHAR2(255) := '병원 철산점 ';
   p_price number := 12500;
   p_storeCategoryCode VARCHAR2(20) := 'MD'; 
   v_card_id card.card_id%type; -- OUT 파라미터
BEGIN
   SP_PICK_CARD(p_date,p_member_id, p_storeName, p_price, p_storeCategoryCode, v_card_id);

   DBMS_OUTPUT.PUT_LINE('결과 card_id: ' || v_card_id);
END;
/
select * from membercard;
select * from benefit where card_id in (7,2,10);
select * from transactionhistory;
select card_id from membercard where card_number = 4439123764500768;
select * from transactionhistory;
select count(*) from search_history;
delete from search_history;
commit;



create or replace PROCEDURE sp_pick_card (
    p_date               IN DATE,
    p_member_id         IN member.member_id%TYPE,
    p_storename         IN VARCHAR2,
    p_price             IN NUMBER,
    p_storecategorycode IN benefit.benefit_industry_code%TYPE,
    out_card_id         OUT card.card_id%TYPE
) AS
    --한 회원이 갖고 있는 카드의 혜택들
    TYPE t_benefit_result IS RECORD (
        benefitcode   CHAR(5),
        benefitamount NUMBER(10, 1),
        benefitmax    VARCHAR2(5),
        cardid        NUMBER
    );
    TYPE t_benefit IS RECORD (
        benefit_id            NUMBER,
        card_id               NUMBER,
        card_performance      NUMBER(10),
        benefit_code          CHAR(5),
        benefit_industry_code VARCHAR2(20),
        benefit_store_name    VARCHAR2(255),
        benefit_amount        NUMBER(10, 1),
        benefit_max           VARCHAR2(10),
        benefit_group_code VARCHAR2(10)
    );

    -- VARRAY 타입 정의
    TYPE card_benefit_list IS
        VARRAY(20) OF t_benefit_result;
    -- VARRAY 변수 선언

    --결과 출력할 것에 대한 혜택 result

    v_benefit_results       card_benefit_list := card_benefit_list(); -- 빈 VARRAY 생성

    v_benefit_result        t_benefit_result; -- 단일 t_benefit 레코드를 저장할 변수

    --그 앞에서 결과에 대한 전체 혜택 DTO객체
    -- v_benefit 배열 선언
    TYPE t_benefit_list IS
        VARRAY(20) OF t_benefit;
    v_benefit_list          t_benefit_list := t_benefit_list();
    v_price                 NUMBER := 0;
    TYPE t_price_list IS
        VARRAY(20) OF NUMBER;
    v_price_list            t_price_list := t_price_list();

    --혜택 한도 횟수 
    v_benefitcount          NUMBER := 0;

    --혜택 한도 금액일 시에 변수 넣기
    v_benefitMaxValue   NUMBER := 0;

    --혜택 한도가 금액일 시에 이번달 같은 혜택으로 거래한 금액 리스트에 담기
    TYPE t_transaction_price_list IS
        VARRAY(99) OF NUMBER;
    v_transaction_price_list  t_transaction_price_list := t_transaction_price_list();

    v_transaction_id_list  t_transaction_price_list := t_transaction_price_list();

    v_transaction_id NUMBER; -- 여기서 데이터 타입을 적절하게 설정해야 합니다.
    v_amount NUMBER;
    --거래내역 금액 말고 원래금액 담을 변수 
    v_origin_price   NUMBER := 0;

    v_min_value             NUMBER := NULL; -- 최솟값 저장 변수
    v_min_index             NUMBER := NULL; -- 최솟값의 인덱스 저장 변수


    v_is_duplicate BOOLEAN;  -- 혜택 찾기 두번째 쿼리에서 중복 여부를 확인하기 위한 변수

    --혜택이 없을 시에 실적관리 관련 변수들

    --카드 번호 별 이용 금액을 map을 통해 관리하기 위한 map 선언
    TYPE cardusagemap IS
        TABLE OF NUMBER INDEX BY VARCHAR2(20);
    cardusage               cardusagemap;
    v_card_number           membercard.card_number%TYPE;
    TYPE t_card_performance_list IS
        TABLE OF NUMBER; 
    --한 카드별 실적들을 담을 리스트 
    v_performance_list      t_card_performance_list := t_card_performance_list();
    --실적들 중 가장 작은 값을 담을 리스트
    v_resultperformance_map cardusagemap;

    --실적 리스트와 카드의 한달 이용금액을 비교해서 큰 값들을 잠시 넣을 리스트 
    -- 이 리스트 안의 값 중에 가장 작은 값을 v_resultperformance_list에 담을 것이다
    v_findmin_list          t_card_performance_list := t_card_performance_list();
    v_min_performance_index PLS_INTEGER; -- 최소값의 인덱스를 저장할 변수
    v_min_performance       NUMBER := 9999999999; -- 최소값을 저장할 변수 (초기값은 충분히 큰 값으로 설정)

    --resultperformance_map 에서 가장 작은 값과 그 값에 대한 카드 번호를 알기 위한 변수들
    v_min_value_performance NUMBER := NULL; -- 최솟값 저장 변수
    v_min_index_performance NUMBER := NULL; -- 최솟값의 인덱스 저장 변수

    --시작 날짜를 설정
    v_startDate DATE;
BEGIN
    dbms_output.put_line('시작');
    FOR c IN (
        SELECT
            b.benefit_code     AS benefitcode,
            MAX(b.benefit_amount) AS benefitamount,
            MAX(b.benefit_max)    AS benefitmax,
            b.card_id             AS cardid
        FROM
                 member m
            JOIN membercard mc ON m.member_id = mc.member_id
            JOIN card       c ON mc.card_id = c.card_id
            JOIN benefit    b ON mc.card_id = b.card_id
        WHERE 
                m.member_id = p_member_id
              AND INSTR(p_storename, b.benefit_store_name) > 0
            AND mc.last_month_total >= b.card_performance
        GROUP BY
            mc.last_month_total,
            b.benefit_code,
            b.card_id
    ) LOOP
        dbms_output.put_line('시작1-2');
        v_benefit_result := t_benefit_result(c.benefitcode, c.benefitamount, c.benefitmax, c.cardid);

        v_benefit_results.extend(1); -- VARRAY 크기 확장
        v_benefit_results(v_benefit_results.count) := v_benefit_result; -- VARRAY에 t_benefit_result 레코드 추가
        dbms_output.put_line('해당가게에서의 나의 혜택 정보 가져오기(실적도 다 생각한)');
    END LOOP;
    dbms_output.put_line('시작2');
     dbms_output.put_line(v_benefit_results.count);
    IF p_storecategorycode ='FD' THEN
   -- 업종으로 card_pick 쿼리의 LOOP
    FOR c2 IN (
        SELECT
            b.benefit_code        AS benefitcode,
            MAX(b.benefit_amount) AS benefitamount,
            MAX(b.benefit_max)    AS benefitmax,
            b.card_id             AS cardid
        FROM
                 member m
            JOIN membercard mc ON m.member_id = mc.member_id
            JOIN card       c ON mc.card_id = c.card_id
            JOIN benefit    b ON mc.card_id = b.card_id
        WHERE
                m.member_id = p_member_id
           AND b.benefit_industry_code = p_storecategorycode
            AND mc.last_month_total >= b.card_performance
        GROUP BY
            mc.last_month_total,
            b.benefit_code,
            b.card_id
    ) LOOP
        v_is_duplicate := FALSE;

        -- 기존의 결과와 비교해서 중복이 있는지 확인
        FOR i IN 1..v_benefit_results.COUNT LOOP
            IF v_benefit_results(i).benefitcode = c2.benefitcode AND
                v_benefit_results(i).cardid = c2.cardid THEN
                v_is_duplicate := TRUE;
                EXIT;
            END IF;
        END LOOP;

        -- 중복이 없다면 결과 추가
        IF v_is_duplicate = FALSE THEN
            v_benefit_result := t_benefit_result(c2.benefitcode, c2.benefitamount, c2.benefitmax, c2.cardid);
            v_benefit_results.extend(1);
            v_benefit_results(v_benefit_results.count) := v_benefit_result;
            dbms_output.put_line('추가 혜택 정보 추가');
        END IF;
    END LOOP;
    END IF;
    -- 혜택이 없을 때 
    IF v_benefit_results.count = 0 THEN
        dbms_output.put_line('혜택이 없다면');

        --이번달 실적 조회 후 실적 찾기
            --카드 번호별 이용 금액 map 초기화
        cardusage := cardusagemap();

        -- 한 회원의 카드 번호와 이용 금액을 가져오는 쿼리
        FOR rec IN (
            SELECT
                t.card_number,
                SUM(transaction_amount) AS total_amount
            FROM
                     transactionhistory t
                JOIN membercard mc ON mc.member_id = t.member_id
            WHERE
                    mc.member_id = p_member_id
                AND to_char(t.transaction_date, 'YYYY-MM') = to_char(p_date, 'YYYY-MM') -- 이번 달의 조건 추가
            GROUP BY
                t.card_number
        ) LOOP
        -- 컬렉션에 카드 번호를 키로 하고 이용 금액을 값으로 추가
            dbms_output.put_line('1');
            cardusage(rec.card_number) := rec.total_amount;
            dbms_output.put_line('Card Number: ' || rec.card_number|| ', Total Amount: '|| rec.total_amount);

        END LOOP;

        dbms_output.put_line('cardusage count: ' || cardusage.count);
        IF cardusage.count = 0 THEN
            --매달 1일 예상 (이번달 사용금액이 없다면)
            dbms_output.put_line('이번달 사용금액이 없다면');        
            SELECT card_id
                INTO out_card_id
            FROM membercard
            WHERE member_id = 'user001'
                ORDER BY DBMS_RANDOM.VALUE
                FETCH FIRST 1 ROW ONLY;
            dbms_output.put_line('결제할 카드 ID는 ' || out_card_id);
        ELSE 
            v_card_number := cardusage.first;
            WHILE v_card_number IS NOT NULL LOOP
            -- 컬렉션의 해당 인덱스가 존재하는지 확인
            IF cardusage.EXISTS(v_card_number) THEN
                dbms_output.put_line('2');
                dbms_output.put_line('Card Number: '
                                     || v_card_number
                                     || ', Total Amount: '
                                     || cardusage(v_card_number));

                --카드 번호와 이번 사용량을 하나 뽑아서 그 카드번호의 카드실적과 비교시작
                    BEGIN
                        FOR rec IN (
                            SELECT
                                b.card_performance
                            FROM
                                 benefit b
                                JOIN membercard mc ON mc.card_id = b.card_id
                            WHERE
                                mc.member_id = p_member_id
                            AND mc.card_number = v_card_number
                            GROUP BY
                                b.card_id,
                                b.card_performance
                        ) LOOP
                            v_performance_list.extend;
                            v_performance_list(v_performance_list.last) := rec.card_performance;
                        END LOOP;

                        FOR i IN v_performance_list.first..v_performance_list.last LOOP
                            dbms_output.put_line(v_performance_list(i)
                                             || ' : price 리스트');
                            IF ( cardusage(v_card_number) - v_performance_list(i) < 0 ) THEN
                                v_findmin_list.extend;
                                v_findmin_list(v_findmin_list.last) := v_performance_list(i);
                            ELSE
                                dbms_output.put_line('실적다채움');
                                v_findmin_list.extend;
                                v_findmin_list(v_findmin_list.last) := 9999999;
                            END IF;

                        END LOOP;

                        FOR j IN v_findmin_list.first..v_findmin_list.last LOOP
                            dbms_output.put_line(v_findmin_list(j)
                                             || ' : v_findmin_list의 값');
                            -- 현재 값이 최소값보다 작으면 최소값과 인덱스를 갱신
                            IF v_findmin_list(j) < v_min_performance THEN
                                v_min_performance := v_findmin_list(j);
                                v_min_performance_index := j;
                            END IF;

                        END LOOP;
                            -- 최소값의 인덱스 출력
                        dbms_output.put_line('최소값의 인덱스: ' || v_min_performance_index);
                        dbms_output.put_line('최소값: ' || v_min_performance);
                        v_resultperformance_map(v_card_number) := v_min_performance - cardusage(v_card_number);
                        dbms_output.put_line('카드번호: '
                                         || v_card_number
                                         || '가 다음등급을 위해 필요한 값: '
                                         || v_resultperformance_map(v_card_number));

                        v_findmin_list.DELETE;
                        v_min_performance := 9999999999; --최솟값 찾기 위해 다시 초기화
                        v_performance_list.DELETE; -- 리스트 초기화
                    END;

                    v_card_number := cardusage.next(v_card_number);
                ELSE
                    v_card_number := v_card_number + 1; -- 존재하지 않는 인덱스를 건너뛰고 다음 인덱스로 이동
                END IF;
            END LOOP;
        --각각의 카드들의 다음등급을 위해 필요한 값 저장된 map 출력
        v_card_number := v_resultperformance_map.first;
        WHILE v_card_number IS NOT NULL LOOP
            IF v_resultperformance_map.EXISTS(v_card_number) THEN
                dbms_output.put_line('v_resultperformance_map 출력');
                dbms_output.put_line('v_resultperformance_map(v_card_number)의 v_card_number는 '
                                     || v_card_number
                                     || '값은 '
                                     || v_resultperformance_map(v_card_number));
                                     -- 최소값 갱신
                IF v_min_value_performance IS NULL OR v_resultperformance_map(v_card_number) < v_min_value_performance THEN
                    v_min_value_performance := v_resultperformance_map(v_card_number);
                    v_min_index_performance := v_card_number; -- 최소값을 가진 카드 번호 업데이트
                END IF;
                v_card_number := v_resultperformance_map.next(v_card_number);
            END IF;
        END LOOP;

        IF v_min_index_performance IS NOT NULL THEN
            dbms_output.put_line('최소값을 가진 카드 번호는 ' || v_min_index_performance);
        ELSE
            dbms_output.put_line('카드 번호가 없습니다.');
        END IF;

        SELECT
            card_id
        INTO out_card_id
        FROM
            membercard
        WHERE
            card_number = v_min_index_performance;
    END IF;
    ELSE
        dbms_output.put_line('혜택이 존재');
        FOR i IN v_benefit_results.first..v_benefit_results.last LOOP
            BEGIN
                    dbms_output.put_line('하나씩 꺼내서 혜택 추가정보 얻어서 benefit_list에 넣기');
                    dbms_output.put_line('v_benefit_result: ' || v_benefit_results(i).benefitcode);
                    dbms_output.put_line('v_benefit_result: ' || v_benefit_results(i).benefitamount);
                    dbms_output.put_line('v_benefit_result: ' || v_benefit_results(i).benefitmax);
                    dbms_output.put_line('v_benefit_result: ' || v_benefit_results(i).cardid);
                    v_benefit_list.extend(1);

                    BEGIN
                        SELECT
                            benefit_id,
                            card_id,
                            card_performance,
                            benefit_code,
                            benefit_industry_code,
                            benefit_store_name,
                            benefit_amount,
                            benefit_max,
                            benefit_group_code
                        INTO
                            v_benefit_list(i)
                        FROM
                            benefit
                        WHERE
                            card_id = v_benefit_results(i).cardid
                                AND benefit_code = v_benefit_results(i).benefitcode
                                AND benefit_amount = v_benefit_results(i).benefitamount
                                AND benefit_max = v_benefit_results(i).benefitmax
                                AND benefit_industry_code = p_storecategorycode
                                AND INSTR(p_storename, benefit_store_name) > 0;

                            EXCEPTION
                                    WHEN no_data_found THEN
                                        dbms_output.put_line('Benefit not found for card_id: ' || v_benefit_results(i).cardid);
                                        SELECT
                                                benefit_id,
                                                card_id,
                                                card_performance,
                                                benefit_code,
                                                benefit_industry_code,
                                                benefit_store_name,
                                                benefit_amount,
                                                benefit_max,
                                                benefit_group_code
                                        INTO
                                            v_benefit_list(i)
                                        FROM
                                            benefit
                                        WHERE
                                            card_id = v_benefit_results(i).cardid
                                            AND benefit_code = v_benefit_results(i).benefitcode
                                            AND benefit_amount = v_benefit_results(i).benefitamount
                                            AND benefit_max = v_benefit_results(i).benefitmax
                                            AND benefit_industry_code = p_storecategorycode 
                                            AND INSTR('국내음식점', benefit_store_name) > 0; 
                                END;
                   END;

            dbms_output.put_line('v_benefit_list(i)의 혜택ID값: ' || v_benefit_list(i).benefit_id);
            dbms_output.put_line('v_benefit_list(i)의 혜택card_performance값: ' || v_benefit_list(i).card_performance);
            dbms_output.put_line('거래내역 조회해서 혜택 한도 체크, 그 혜택을 몇번 받았는 가 체크');
            v_benefitcount := 0;
            dbms_output.put_line('초기 count값' || v_benefitcount);
            SELECT
                COUNT(DISTINCT t.transaction_id)
            INTO v_benefitcount
            FROM
                     transactionhistory t
                JOIN membercard mc ON mc.member_id = t.member_id
                JOIN benefit    b ON mc.card_id = b.card_id
            WHERE
                    t.member_id = p_member_id
                AND t.card_number = mc.card_number
                AND mc.card_id = v_benefit_list(i).card_id
                AND b.card_performance = v_benefit_list(i).card_performance
                AND t.transaction_industry_code = p_storecategorycode
                AND EXTRACT(MONTH FROM t.transaction_date) = EXTRACT(MONTH FROM p_date)
                AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date); -- 이번 달 거래 내역만 고려;
            dbms_output.put_line('이번달에 그 혜택 받은 횟수' || v_benefitcount);
            IF substr(v_benefit_list(i).benefit_code, 1, 2) = 'DC' THEN
                dbms_output.put_line('해당 혜택의 방식이 할인이라면');
                dbms_output.put_line('해당 혜택의 한도' || v_benefit_list(i).benefit_max);
                IF substr(v_benefit_list(i).benefit_code, 4, 1) = 'C' THEN
                    IF v_benefitcount < v_benefit_list(i).benefit_max THEN
                        IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
                            v_price := p_price - v_benefit_list(i).benefit_amount;
                            dbms_output.put_line('Price : ' || v_price);
                        ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                            v_price := p_price - ( p_price * v_benefit_list(i).benefit_amount / 100 );
                        END IF;

                    ELSE
                        dbms_output.put_line('해당 혜택의 한도를 초과했다');
                        v_price := p_price;
                    END IF;
                ELSIF substr(v_benefit_list(i).benefit_code, 4, 1) = 'A' THEN
                    v_benefitMaxValue := v_benefit_list(i).benefit_max;
                    BEGIN
                        FOR rec IN (
                            SELECT t.transaction_id
                            FROM transactionhistory t
                            JOIN membercard mc ON mc.member_id = t.member_id
                            JOIN benefit b ON mc.card_id = b.card_id
                            WHERE t.member_id = p_member_id
                            AND t.card_number = mc.card_number
                            AND mc.card_id = v_benefit_list(i).card_id
                            AND b.card_performance = v_benefit_list(i).card_performance
                            AND t.transaction_industry_code = p_storecategorycode
                            AND EXTRACT(MONTH FROM t.transaction_date) = EXTRACT(MONTH FROM p_date)
                            AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date)
                            GROUP BY t.transaction_id
                        ) LOOP
                            v_transaction_id_list.EXTEND;
                            v_transaction_id_list(v_transaction_id_list.COUNT) := rec.transaction_id;
                    
                            SELECT transaction_amount
                            INTO v_amount
                            FROM transactionhistory
                            WHERE transaction_id = rec.transaction_id;
                    
                            v_transaction_price_list.EXTEND;
                            v_transaction_price_list(v_transaction_price_list.COUNT) := v_amount;
                        END LOOP;
                    
                        dbms_output.put_line('transaction_id_list의 count: ' || v_transaction_id_list.count);
                    END;

                    dbms_output.put_line('같은 혜택을 적용한 거래 리스트 count: ' || v_transaction_price_list.count);                    
                    --이제 혜택 한도 금액 넘었는 지 따져야함 
                    --거래금액 리스트 길이만큼 일단 루프 돌려야함
                    --이번 결제가 첫번째 혜택을 받은 거래가 아니라면 for 문 loop 시작
                    IF v_transaction_price_list.count != 0 THEN
                        FOR j IN v_transaction_price_list.first..v_transaction_price_list.last LOOP
                        dbms_output.put_line('v_transaction_price_list 루프 시작');
                            --원래 금액 따질 변수 초기화 
                            v_origin_price := 0;
                             --거래내역 원래 금액 
                             --v_origin_price := v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100);                      
                            --BEGIN
                             dbms_output.put_line(substr(v_benefit_list(i).benefit_code, 3, 1));
                             dbms_output.put_line(v_benefit_list(i).benefit_amount/100);
                             dbms_output.put_line((1- v_benefit_list(i).benefit_amount/100));
                             dbms_output.put_line(v_transaction_price_list(j));
                             dbms_output.put_line(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                                    --v_transaction_price_list(i)이 지금 금액 
                                    IF (1- v_benefit_list(i).benefit_amount/100) <> 0 THEN
                                        v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                        dbms_output.put_line('분모가 0이 아님.');
                                    ELSE
                                        -- 0으로 나누려는 시도를 했을 때의 예외 처리
                                        dbms_output.put_line('분모가 0임.');
                                        -- 필요한 경우, 다른 조치를 취하십시오.
                                    END IF;

--                                    v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                      v_benefitMaxValue := v_benefitMaxValue- (v_origin_price - v_transaction_price_list(j));      
                                   -- (23.10.09) v_benefit_list(i).benefit_max := TO_CHAR(v_benefit_list(i).benefit_max - (v_origin_price - v_transaction_price_list(j)));
                                ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
                                    -- (23.10.09) v_benefit_list(i).benefit_max := v_benefit_list(i).benefit_max - v_benefit_list(i).benefit_amount;
                                    v_benefitMaxValue := v_benefitMaxValue - v_benefit_list(i).benefit_amount;
                                END IF;
                            --END;
                        END LOOP;
                    END IF;
                    dbms_output.put_line('이번달 남은 혜택 한도 : ' || v_benefitMaxValue);
                    --(23.10.09) IF v_benefit_list(i).benefit_max > 0  THEN
                    IF v_benefitMaxValue > 0  THEN
                        IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                            --(23.10.09) IF v_benefit_list(i).benefit_max > ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                            IF v_benefitMaxValue > ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                                v_price := p_price - ( p_price * v_benefit_list(i).benefit_amount / 100 );
                            --(23.10.09) ELSIF v_benefit_list(i).benefit_max <= ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                            ELSIF v_benefitMaxValue <= ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                                --(23.10.09)v_price := p_price - ( p_price * v_benefit_list(i).benefit_max / 100 );
                                v_price := p_price - v_benefitMaxValue;
                            END IF;
                        ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
                            --(23.10.09) IF v_benefit_list(i).benefit_amount < v_benefit_list(i).benefit_max THEN
                            IF v_benefit_list(i).benefit_amount < v_benefitMaxValue THEN
                                v_price := p_price - v_benefit_list(i).benefit_amount;
                            --(23.10.09)ELSIF v_benefit_list(i).benefit_amount >= v_benefit_list(i).benefit_max THEN
                            ELSIF v_benefit_list(i).benefit_amount >= v_benefitMaxValue THEN
                                --(23.10.09)v_price := p_price - v_benefit_list(i).benefit_max;
                                v_price := p_price - v_benefitMaxValue;
                            END IF;
                        END IF;
                    ELSE
                         v_price:= p_price;
                    END IF;
--                -- v_price 값을 v_price_list VARRAY에 추가
--                v_price_list.extend(1); -- VARRAY 크기 확장
--                v_price_list(v_price_list.count) := v_price; -- VARRAY에 price 추가
                END IF;

                dbms_output.put_line('헤택 마다의 해당 가격을 리스트에 추가할 것' || v_price);
                v_price_list.extend(1); -- VARRAY 크기 확장
                v_price_list(v_price_list.count) := v_price; -- VARRAY에 price 추가
            ELSIF substr(v_benefit_list(i).benefit_code, 1, 2) = 'AC' THEN
                dbms_output.put_line('해당 혜택의 방식이 적립이라면');
--                IF substr(v_benefit_list(i).benefit_code, 4, 1) = 'C' THEN
--                    IF v_benefitcount < v_benefit_list(i).benefit_max THEN
--                        IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
--                            v_price := p_price - v_benefit_list(i).benefit_amount;
--                            dbms_output.put_line('Price : ' || v_price);
--                        ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
--                            v_price := p_price - ( p_price * v_benefit_list(i).benefit_amount / 100 );
--                        END IF;
--
--                    ELSE
--                        v_price := p_price;
--                    END IF;
--
--                ELSIF substr(v_benefit_list(i).benefit_code, 4, 1) = 'A' THEN
--                    v_benefitMaxValue := v_benefit_list(i).benefit_max;
--                    BEGIN
--                        FOR rec IN (
--                            SELECT t.transaction_id
--                            FROM transactionhistory t
--                            JOIN membercard mc ON mc.member_id = t.member_id
--                            JOIN benefit b ON mc.card_id = b.card_id
--                            WHERE t.member_id = p_member_id
--                            AND t.card_number = mc.card_number
--                            AND mc.card_id = v_benefit_list(i).card_id
--                            AND b.card_performance = v_benefit_list(i).card_performance
--                            AND t.transaction_industry_code = p_storecategorycode
--                            AND EXTRACT(MONTH FROM t.transaction_date) = EXTRACT(MONTH FROM p_date)
--                            AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date)
--                            GROUP BY t.transaction_id
--                        ) LOOP
--                            v_transaction_id_list.EXTEND;
--                            v_transaction_id_list(v_transaction_id_list.COUNT) := rec.transaction_id;
--                    
--                            SELECT transaction_amount
--                            INTO v_amount
--                            FROM transactionhistory
--                            WHERE transaction_id = rec.transaction_id;
--                    
--                            v_transaction_price_list.EXTEND;
--                            v_transaction_price_list(v_transaction_price_list.COUNT) := v_amount;
--                        END LOOP;
--                    
--                        dbms_output.put_line('transaction_id_list의 count: ' || v_transaction_id_list.count);
--                    END;
--                    dbms_output.put_line('같은 혜택을 적용한 거래 리스트 count: ' || v_transaction_price_list.count);                    
--                    --이제 혜택 한도 금액 넘었는 지 따져야함 
--                    --거래금액 리스트 길이만큼 일단 루프 돌려야함
--                    --이번 결제가 첫번째 혜택을 받은 거래가 아니라면 for 문 loop 시작
--                    IF v_transaction_price_list.count != 0 THEN
--                        FOR j IN v_transaction_price_list.first..v_transaction_price_list.last LOOP
--                        dbms_output.put_line('v_transaction_price_list 루프 시작');
--                            --원래 금액 따질 변수 초기화 
--                            v_origin_price := 0;
--                             --거래내역 원래 금액 
--                             v_origin_price := v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100);                      
--                            --BEGIN
--                             dbms_output.put_line(substr(v_benefit_list(i).benefit_code, 3, 1));
--                             dbms_output.put_line(v_benefit_list(i).benefit_amount/100);
--                             dbms_output.put_line((1- v_benefit_list(i).benefit_amount/100));
--                             dbms_output.put_line(v_transaction_price_list(j));
--                             dbms_output.put_line(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
--                             dbms_output.put_line(ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100)));
--                                IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
--                                    --v_transaction_price_list(i)이 지금 금액 
--                                    IF (1- v_benefit_list(i).benefit_amount/100) <> 0 THEN
--                                        v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
--                                         dbms_output.put_line('분모가 0이 아님.');
--                                    ELSE
--                                        -- 0으로 나누려는 시도를 했을 때의 예외 처리
--                                        dbms_output.put_line('분모가 0임.');
--                                        -- 필요한 경우, 다른 조치를 취하십시오.
--                                    END IF;
--
----                                    v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
--                                    v_benefit_list(i).benefit_max := v_benefit_list(i).benefit_max - (v_origin_price - v_transaction_price_list(j));   
--
--                                ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
--                                    v_benefit_list(i).benefit_max := v_benefit_list(i).benefit_max - v_benefit_list(i).benefit_amount;
--                                END IF;
--                            --END;
--                        END LOOP;
--                    END IF;
--                    dbms_output.put_line('이번달 남은 혜택 한도 : ' || v_benefit_list(i).benefit_max);
--
--
--                    IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
--                        IF v_benefit_list(i).benefit_max > ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
--                            v_price := p_price - ( p_price * v_benefit_list(i).benefit_amount / 100 );
--                        ELSIF v_benefit_list(i).benefit_max <= ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
--                            v_price := p_price - ( p_price * v_benefit_list(i).benefit_max / 100 );
--                        END IF;
--
--                    ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
--                        IF v_benefit_list(i).benefit_amount < v_benefit_list(i).benefit_max THEN
--                            v_price := p_price - v_benefit_list(i).benefit_amount;
--                        ELSIF v_benefit_list(i).benefit_amount >= v_benefit_list(i).benefit_max THEN
--                            v_price := p_price - v_benefit_list(i).benefit_max;
--                        END IF;
--                    END IF;
--                END IF;
              IF substr(v_benefit_list(i).benefit_code, 4, 1) = 'C' THEN
                    IF v_benefitcount < v_benefit_list(i).benefit_max THEN
                        IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
                            v_price := p_price - v_benefit_list(i).benefit_amount;
                            dbms_output.put_line('Price : ' || v_price);
                        ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                            v_price := p_price - ( p_price * v_benefit_list(i).benefit_amount / 100 );
                        END IF;

                    ELSE
                        dbms_output.put_line('해당 혜택의 한도를 초과했다');
                        v_price := p_price;
                    END IF;
                ELSIF substr(v_benefit_list(i).benefit_code, 4, 1) = 'A' THEN

                    v_benefitMaxValue := v_benefit_list(i).benefit_max;
                    BEGIN
                        FOR rec IN (
                            SELECT t.transaction_id
                            FROM transactionhistory t
                            JOIN membercard mc ON mc.member_id = t.member_id
                            JOIN benefit b ON mc.card_id = b.card_id
                            WHERE t.member_id = p_member_id
                            AND t.card_number = mc.card_number
                            AND mc.card_id = v_benefit_list(i).card_id
                            AND b.card_performance = v_benefit_list(i).card_performance
                            AND t.transaction_industry_code = p_storecategorycode
                            AND EXTRACT(MONTH FROM t.transaction_date) = EXTRACT(MONTH FROM p_date)
                            AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date)
                            GROUP BY t.transaction_id
                        ) LOOP
                            v_transaction_id_list.EXTEND;
                            v_transaction_id_list(v_transaction_id_list.COUNT) := rec.transaction_id;
                    
                            SELECT transaction_amount
                            INTO v_amount
                            FROM transactionhistory
                            WHERE transaction_id = rec.transaction_id;
                    
                            v_transaction_price_list.EXTEND;
                            v_transaction_price_list(v_transaction_price_list.COUNT) := v_amount;
                        END LOOP;
                    
                        dbms_output.put_line('transaction_id_list의 count: ' || v_transaction_id_list.count);
                    END;

                    dbms_output.put_line('같은 혜택을 적용한 거래 리스트 count: ' || v_transaction_price_list.count);                    
                    --이제 혜택 한도 금액 넘었는 지 따져야함 
                    --거래금액 리스트 길이만큼 일단 루프 돌려야함
                    --이번 결제가 첫번째 혜택을 받은 거래가 아니라면 for 문 loop 시작
                    IF v_transaction_price_list.count != 0 THEN
                        FOR j IN v_transaction_price_list.first..v_transaction_price_list.last LOOP
                        dbms_output.put_line('v_transaction_price_list 루프 시작');
                            --원래 금액 따질 변수 초기화 
                            v_origin_price := 0;
                             --거래내역 원래 금액 
                             --v_origin_price := v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100);                      
                            --BEGIN
                             dbms_output.put_line(substr(v_benefit_list(i).benefit_code, 3, 1));
                             dbms_output.put_line(v_benefit_list(i).benefit_amount/100);
                             dbms_output.put_line((1- v_benefit_list(i).benefit_amount/100));
                             dbms_output.put_line(v_transaction_price_list(j));
                             dbms_output.put_line(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                                    --v_transaction_price_list(i)이 지금 금액 
                                    IF (1- v_benefit_list(i).benefit_amount/100) <> 0 THEN
                                        v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                        dbms_output.put_line('분모가 0이 아님.');
                                    ELSE
                                        -- 0으로 나누려는 시도를 했을 때의 예외 처리
                                        dbms_output.put_line('분모가 0임.');
                                        -- 필요한 경우, 다른 조치를 취하십시오.
                                    END IF;

--                                    v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                      v_benefitMaxValue := v_benefitMaxValue- (v_origin_price - v_transaction_price_list(j));      
                                   -- (23.10.09) v_benefit_list(i).benefit_max := TO_CHAR(v_benefit_list(i).benefit_max - (v_origin_price - v_transaction_price_list(j)));
                                ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
                                    -- (23.10.09) v_benefit_list(i).benefit_max := v_benefit_list(i).benefit_max - v_benefit_list(i).benefit_amount;
                                    v_benefitMaxValue := v_benefitMaxValue - v_benefit_list(i).benefit_amount;
                                END IF;
                            --END;
                        END LOOP;
                    END IF;
                    dbms_output.put_line('이번달 남은 혜택 한도 : ' || v_benefitMaxValue);
                    --(23.10.09) IF v_benefit_list(i).benefit_max > 0  THEN
                    IF v_benefitMaxValue > 0  THEN
                        IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                            --(23.10.09) IF v_benefit_list(i).benefit_max > ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                            IF v_benefitMaxValue > ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                                v_price := p_price - ( p_price * v_benefit_list(i).benefit_amount / 100 );
                            --(23.10.09) ELSIF v_benefit_list(i).benefit_max <= ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                            ELSIF v_benefitMaxValue <= ( p_price * v_benefit_list(i).benefit_amount / 100 ) THEN
                                --(23.10.09)v_price := p_price - ( p_price * v_benefit_list(i).benefit_max / 100 );
                                v_price := p_price - v_benefitMaxValue;
                            END IF;
                        ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
                            --(23.10.09) IF v_benefit_list(i).benefit_amount < v_benefit_list(i).benefit_max THEN
                            IF v_benefit_list(i).benefit_amount < v_benefitMaxValue THEN
                                v_price := p_price - v_benefit_list(i).benefit_amount;
                            --(23.10.09)ELSIF v_benefit_list(i).benefit_amount >= v_benefit_list(i).benefit_max THEN
                            ELSIF v_benefit_list(i).benefit_amount >= v_benefitMaxValue THEN
                                --(23.10.09)v_price := p_price - v_benefit_list(i).benefit_max;
                                v_price := p_price - v_benefitMaxValue;
                            END IF;
                        END IF;
                    ELSE
                         v_price:= p_price;
                    END IF;
--                -- v_price 값을 v_price_list VARRAY에 추가
--                v_price_list.extend(1); -- VARRAY 크기 확장
--                v_price_list(v_price_list.count) := v_price; -- VARRAY에 price 추가
                END IF;
                dbms_output.put_line('헤택 마다의 해당 가격을 리스트에 추가할 것' || v_price);
                v_price_list.extend(1); -- VARRAY 크기 확장
                v_price_list(v_price_list.count) := v_price; -- VARRAY에 price 추가
            END IF;

        END LOOP;

        -- VARRAY 안에서 최솟값 및 해당 인덱스 찾기
        FOR i IN v_price_list.first..v_price_list.last LOOP
            dbms_output.put_line('v_price_list(i): ' || v_price_list(i));
            IF v_price_list(i) < v_min_value OR v_min_value IS NULL THEN
                v_min_value := v_price_list(i); -- 최솟값 갱신
                v_min_index := i; -- 최솟값의 인덱스 갱신
            END IF;

        END LOOP;

        -- 최솟값 및 해당 인덱스 출력
        dbms_output.put_line('Min Value: ' || v_min_value);
        dbms_output.put_line('Min Index: ' || v_min_index);
        -- 최솟값을 가진 v_benefit_results의 card_id를 리턴

        IF v_min_index IS NOT NULL THEN
            out_card_id := v_benefit_list(v_min_index).card_id;
            dbms_output.put_line('결과 card_id: ' || out_card_id);
        END IF;

    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Exception 발생: ' || sqlerrm);
END sp_pick_card;
/

select * from industry_code;
-------------------------------------------------------------
create or replace PROCEDURE SP_SUBMIT_PAYMENT(
    p_date           IN transactionhistory.transaction_date%TYPE,
    p_member_id IN member.member_id%type,
    p_card_id IN card.card_id%type,
    p_storeName IN VARCHAR2,
    p_price IN number,
    p_storeCategoryCode IN benefit.benefit_industry_code%type,
    OUT_TRANSACTION_ID OUT transactionhistory.transaction_id%type
)
AS
    v_card_number varchar(20);
    v_benefit_id NUMBER;

    TYPE t_benefit IS RECORD (
        benefit_id number,
        card_id number,
        cardPerformance NUMBER(10),
        benefitCode char(5),
        benefit_industry_code varchar2(20),
        benefit_store_name varchar2(255),
        benefitAmount NUMBER(10,1),
        benefitMax     varchar2(5),
        benefit_group_code varchar2(10)
        );

    v_benefit t_benefit;
    v_benefitCount NUMBER;
    v_price NUMBER := 0; -- 또는 다른 기본값으로 초기화

BEGIN
    -- Get card number
    SELECT card_number
    INTO v_card_number
    FROM membercard
    WHERE card_id = p_card_id AND member_id = p_member_id;

    BEGIN
        -- Check if there's a benefit
        SELECT b.benefit_id
        INTO v_benefit_id
        FROM member m
                JOIN membercard mc ON m.member_id = mc.member_id
                JOIN benefit b ON b.card_id = mc.card_id
        WHERE m.member_id = p_member_id
            AND UPPER(SUBSTR(p_storeName, 1, INSTR(p_storeName, ' ') - 1)) = UPPER(b.benefit_store_name)
            AND mc.last_month_total >= b.card_performance
            AND mc.card_id = p_card_id
        ORDER BY b.benefit_max desc 
        FETCH FIRST 1 ROWS ONLY;

        DBMS_OUTPUT.PUT_LINE(v_benefit_id);
        SELECT *
        INTO v_benefit
        FROM benefit b
        WHERE b.benefit_id = v_benefit_id; 

        SELECT count(DISTINCT t.transaction_id)
        INTO v_benefitCount
        FROM transactionhistory t
            JOIN membercard mc on mc.member_id = t.member_id
            JOIN benefit b on mc.card_id = b.card_id            
        WHERE t.member_id = p_member_id
        AND b.card_performance = v_benefit.cardPerformance
        AND t.transaction_industry_code = p_storeCategoryCode
        AND EXTRACT(MONTH FROM t.transaction_date) = EXTRACT(MONTH FROM p_date)
        AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date); -- 이번 달 거래 내역만 고려

        DBMS_OUTPUT.PUT_LINE(v_benefitCount);
        IF SUBSTR(v_benefit.benefitCode, 1, 2) = 'DC' THEN
            IF SUBSTR(v_benefit.benefitCode, 4, 1) = 'C' THEN
                IF v_benefitCount < v_benefit.benefitMax THEN
                    IF SUBSTR(v_benefit.benefitCode, 3, 1) = 'V' THEN
                        v_price := p_price - v_benefit.benefitAmount;
                        DBMS_OUTPUT.PUT_LINE('Price : ' || v_price);
                    ELSIF SUBSTR(v_benefit.benefitCode, 3, 1) = 'P' THEN
                        v_price := p_price - (p_price * v_benefit.benefitAmount / 100);
                    END IF;
                ELSE 
                    v_price := p_price;
                END IF;
            ELSIF SUBSTR(v_benefit.benefitCode, 4, 1) = 'A' THEN
                IF SUBSTR(v_benefit.benefitCode, 3, 1) = 'P' THEN
                    IF v_benefit.benefitMax > (p_price * v_benefit.benefitAmount / 100) THEN
                        v_price := p_price - (p_price * v_benefit.benefitAmount / 100);
                    ELSIF v_benefit.benefitMax <= (p_price * v_benefit.benefitAmount / 100) THEN
                        v_price := p_price - (p_price * v_benefit.benefitMax / 100);
                    END IF; 
                ELSIF SUBSTR(v_benefit.benefitCode, 3, 1) = 'V' THEN
                    IF v_benefit.benefitAmount < v_benefit.benefitMax THEN
                        v_price := p_price - v_benefit.benefitAmount;
                    ELSIF v_benefit.benefitAmount >= v_benefit.benefitMax THEN
                        v_price := p_price - v_benefit.benefitMax;
                    END IF;
                END IF; -- 이 END IF가 추가됨
            END IF; -- 이 END IF도 추가됨
        ELSIF SUBSTR(v_benefit.benefitCode, 1, 2) = 'AC' THEN
            -- 'AC' 관련 로직: 혜택이 적용되지 않으므로 별도의 처리 없이 아래의 거래 내역 추가로 넘어감
              v_price := p_price; 
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('혜택 없음');
            v_price := p_price;

    END;

    -- At the end, insert the transaction
    INSERT INTO transactionhistory (transaction_date,transaction_amount, card_number, member_id, transaction_industry_code, transaction_store_name)
    VALUES (p_date, v_price, v_card_number, p_member_id, p_storeCategoryCode, p_storeName)
    RETURNING transaction_id INTO OUT_TRANSACTION_ID;

END SP_SUBMIT_PAYMENT;

/


commit;
