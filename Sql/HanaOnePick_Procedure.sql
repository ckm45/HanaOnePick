REM ******************************************************************************************************************************************
REM SCRIPT �뵵 : ���� �����͸� ����� ���� ���ν��� 
REM �ۼ��� : �ְ��
REM �ۼ��� : 2023-09-14, Version 1
REM ������ : 2023-09-14, Version 1
REM         2023-09-15, Version 1.1
REM        
REM ���ǻ��� : 
REM �������� : 2023-09-15 �ְ�� ���� ���ν��� ���� ���� �����ؼ� �� Ȯ��
REM           2023-09-15 �ְ�� ���� ���ν����� �Ѵ޸� ������ �Ѵ޵ڿ� �ٽ� �ʱ�ȭ�ؼ� ���� ������ �ð� ����
REM           2023-09-15 �ְ�� ������ ī�� PICK ���ν��� ���� version1 , ���� �� price�� �������� card_id�� ����� pick �ȵ� ���� �߻�
REM           2023-09-16 �ְ�� ������ ī�� pick ���ν��� �� �ŷ��������� ���� ��Ȳ ��ȸ�� ���� ����(card_id�� ���ǿ� �߰�- �ش� ������ Ư�� ī�带 ��ȸ�ϰԲ�),
REM           2023-09-16 �ְ�� ������ ī�� pick ���ν��� �� price list�� �ִ� ������ loop���� �ִ� ��ġ �����ؼ� 15���� ���� �ذ�
REM           2023-09-19 �ְ�� ������ ī�� pick ���ν��� �� ������ ���� ��� �������� ���� (����ó�� ��������)
REM           2023-09-20 �ְ�� ������ ī�� pick ���ν��� �� ������ ���� ��� ������ ���� ���� ���� ī�� ��õ���� 
REM           2023-10-03 �ְ�� ������ ī�� pick ���ν��� �� ������ ���� ��� �������� �ѹ��� ã����
REM           2023-10-08 �ְ�� ������ ī�� pick ���ν��� �� ù��° ���� ���� �ȵǰ� �־���. p_storename�� �Ű������� �ƴ� ���ڿ��� �νĵǰ� �־���
REM           2023-10-08 �ְ�� INSTR('p_storename', b.benefit_store_name) > 0  -> INSTR(p_storename, b.benefit_store_name) > 0
REM           2023-10-08 �ְ�� ������ ī�� pick ���ν������� ���� DTO �߰� ���� ��� �������� ���Ը� ������ �ִµ� ������������ ���� ã������ �ʴ´� (�� ����ó�� �߰��غ���)
REM                                         BEGIN �ȿ� BEGIN�� �־� ��ø���� ����ó�� �߰���
REM                                         ��� : ���� ã�⸦ �������� �ѹ� �� �� �������� ��� ���������� �ѹ��� ã�´�
REM                                         ������ ī�� pick ���ν������� �ѵ��� �ݾ��� ��츦 ������ pick �ϴ� ���� �߰���
REM ********************************************************************************************************************************************************
SET SERVEROUTPUT ON
update membercard set last_month_total = 500000 where card_number = 4203754097906696;
commit;
select * from membercard;
select * from transactionhistory;
--�ΰ��� ���ν��� ���� ���� (���� ���� ī�� pick �Ŀ� ����)
-- SP_PICK_CARD ���ν��� ȣ��
select * from transactionhistory order by transaction_id;
DECLARE
   p_date transactionhistory.transaction_date%TYPE := '20221014';
   p_member_id varchar2(20) := 'user001'; 
   p_storeName VARCHAR2(255) := '��Ÿ���� ö����'; 
   p_price number := 14200;
   p_storeCategoryCode VARCHAR2(20) := 'CE'; 
   v_card_id card.card_id%type; -- OUT �Ķ����
BEGIN
   SP_PICK_CARD(p_date,p_member_id, p_storeName, p_price, p_storeCategoryCode, v_card_id);
   -- v_card_id�� ����Ͽ� SP_SUBMIT_PAYMENT�� ȣ���մϴ�.
   
   -- SP_SUBMIT_PAYMENT ���ν��� ȣ��
   DECLARE
     v_transaction_id transactionhistory.transaction_id%type;
   BEGIN
     SP_SUBMIT_PAYMENT(
       p_date => p_date,
       p_member_id => p_member_id, -- ������ ������ ���� �״�� ���
       p_card_id => v_card_id,    -- v_card_id ���� ����մϴ�.
       p_storeName => p_storeName,  -- ������ ������ ���� �״�� ���
       p_price => p_price,        -- ������ ������ ���� �״�� ���
       p_storeCategoryCode => p_storeCategoryCode,  -- ������ ������ ���� �״�� ���
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
--���� ���ν��� ����  
DECLARE
  v_transaction_id transactionhistory.transaction_id%type;
BEGIN
  SP_SUBMIT_PAYMENT(
    p_date => '20220920',
    p_member_id => 'user001',
    p_card_id => '1',
    p_storeName => 'GS���� ',
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

-- ī�� pick ���ν��� ���� 
DECLARE
   p_date transactionhistory.transaction_date%TYPE := '20221006';
   p_member_id varchar2(20) := 'user001'; 
   p_storeName VARCHAR2(255) := '���� ö���� ';
   p_price number := 12500;
   p_storeCategoryCode VARCHAR2(20) := 'MD'; 
   v_card_id card.card_id%type; -- OUT �Ķ����
BEGIN
   SP_PICK_CARD(p_date,p_member_id, p_storeName, p_price, p_storeCategoryCode, v_card_id);

   DBMS_OUTPUT.PUT_LINE('��� card_id: ' || v_card_id);
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
    --�� ȸ���� ���� �ִ� ī���� ���õ�
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

    -- VARRAY Ÿ�� ����
    TYPE card_benefit_list IS
        VARRAY(20) OF t_benefit_result;
    -- VARRAY ���� ����

    --��� ����� �Ϳ� ���� ���� result

    v_benefit_results       card_benefit_list := card_benefit_list(); -- �� VARRAY ����

    v_benefit_result        t_benefit_result; -- ���� t_benefit ���ڵ带 ������ ����

    --�� �տ��� ����� ���� ��ü ���� DTO��ü
    -- v_benefit �迭 ����
    TYPE t_benefit_list IS
        VARRAY(20) OF t_benefit;
    v_benefit_list          t_benefit_list := t_benefit_list();
    v_price                 NUMBER := 0;
    TYPE t_price_list IS
        VARRAY(20) OF NUMBER;
    v_price_list            t_price_list := t_price_list();

    --���� �ѵ� Ƚ�� 
    v_benefitcount          NUMBER := 0;

    --���� �ѵ� �ݾ��� �ÿ� ���� �ֱ�
    v_benefitMaxValue   NUMBER := 0;

    --���� �ѵ��� �ݾ��� �ÿ� �̹��� ���� �������� �ŷ��� �ݾ� ����Ʈ�� ���
    TYPE t_transaction_price_list IS
        VARRAY(99) OF NUMBER;
    v_transaction_price_list  t_transaction_price_list := t_transaction_price_list();

    v_transaction_id_list  t_transaction_price_list := t_transaction_price_list();

    v_transaction_id NUMBER; -- ���⼭ ������ Ÿ���� �����ϰ� �����ؾ� �մϴ�.
    v_amount NUMBER;
    --�ŷ����� �ݾ� ���� �����ݾ� ���� ���� 
    v_origin_price   NUMBER := 0;

    v_min_value             NUMBER := NULL; -- �ּڰ� ���� ����
    v_min_index             NUMBER := NULL; -- �ּڰ��� �ε��� ���� ����


    v_is_duplicate BOOLEAN;  -- ���� ã�� �ι�° �������� �ߺ� ���θ� Ȯ���ϱ� ���� ����

    --������ ���� �ÿ� �������� ���� ������

    --ī�� ��ȣ �� �̿� �ݾ��� map�� ���� �����ϱ� ���� map ����
    TYPE cardusagemap IS
        TABLE OF NUMBER INDEX BY VARCHAR2(20);
    cardusage               cardusagemap;
    v_card_number           membercard.card_number%TYPE;
    TYPE t_card_performance_list IS
        TABLE OF NUMBER; 
    --�� ī�庰 �������� ���� ����Ʈ 
    v_performance_list      t_card_performance_list := t_card_performance_list();
    --������ �� ���� ���� ���� ���� ����Ʈ
    v_resultperformance_map cardusagemap;

    --���� ����Ʈ�� ī���� �Ѵ� �̿�ݾ��� ���ؼ� ū ������ ��� ���� ����Ʈ 
    -- �� ����Ʈ ���� �� �߿� ���� ���� ���� v_resultperformance_list�� ���� ���̴�
    v_findmin_list          t_card_performance_list := t_card_performance_list();
    v_min_performance_index PLS_INTEGER; -- �ּҰ��� �ε����� ������ ����
    v_min_performance       NUMBER := 9999999999; -- �ּҰ��� ������ ���� (�ʱⰪ�� ����� ū ������ ����)

    --resultperformance_map ���� ���� ���� ���� �� ���� ���� ī�� ��ȣ�� �˱� ���� ������
    v_min_value_performance NUMBER := NULL; -- �ּڰ� ���� ����
    v_min_index_performance NUMBER := NULL; -- �ּڰ��� �ε��� ���� ����

    --���� ��¥�� ����
    v_startDate DATE;
BEGIN
    dbms_output.put_line('����');
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
        dbms_output.put_line('����1-2');
        v_benefit_result := t_benefit_result(c.benefitcode, c.benefitamount, c.benefitmax, c.cardid);

        v_benefit_results.extend(1); -- VARRAY ũ�� Ȯ��
        v_benefit_results(v_benefit_results.count) := v_benefit_result; -- VARRAY�� t_benefit_result ���ڵ� �߰�
        dbms_output.put_line('�ش簡�Կ����� ���� ���� ���� ��������(������ �� ������)');
    END LOOP;
    dbms_output.put_line('����2');
     dbms_output.put_line(v_benefit_results.count);
    IF p_storecategorycode ='FD' THEN
   -- �������� card_pick ������ LOOP
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

        -- ������ ����� ���ؼ� �ߺ��� �ִ��� Ȯ��
        FOR i IN 1..v_benefit_results.COUNT LOOP
            IF v_benefit_results(i).benefitcode = c2.benefitcode AND
                v_benefit_results(i).cardid = c2.cardid THEN
                v_is_duplicate := TRUE;
                EXIT;
            END IF;
        END LOOP;

        -- �ߺ��� ���ٸ� ��� �߰�
        IF v_is_duplicate = FALSE THEN
            v_benefit_result := t_benefit_result(c2.benefitcode, c2.benefitamount, c2.benefitmax, c2.cardid);
            v_benefit_results.extend(1);
            v_benefit_results(v_benefit_results.count) := v_benefit_result;
            dbms_output.put_line('�߰� ���� ���� �߰�');
        END IF;
    END LOOP;
    END IF;
    -- ������ ���� �� 
    IF v_benefit_results.count = 0 THEN
        dbms_output.put_line('������ ���ٸ�');

        --�̹��� ���� ��ȸ �� ���� ã��
            --ī�� ��ȣ�� �̿� �ݾ� map �ʱ�ȭ
        cardusage := cardusagemap();

        -- �� ȸ���� ī�� ��ȣ�� �̿� �ݾ��� �������� ����
        FOR rec IN (
            SELECT
                t.card_number,
                SUM(transaction_amount) AS total_amount
            FROM
                     transactionhistory t
                JOIN membercard mc ON mc.member_id = t.member_id
            WHERE
                    mc.member_id = p_member_id
                AND to_char(t.transaction_date, 'YYYY-MM') = to_char(p_date, 'YYYY-MM') -- �̹� ���� ���� �߰�
            GROUP BY
                t.card_number
        ) LOOP
        -- �÷��ǿ� ī�� ��ȣ�� Ű�� �ϰ� �̿� �ݾ��� ������ �߰�
            dbms_output.put_line('1');
            cardusage(rec.card_number) := rec.total_amount;
            dbms_output.put_line('Card Number: ' || rec.card_number|| ', Total Amount: '|| rec.total_amount);

        END LOOP;

        dbms_output.put_line('cardusage count: ' || cardusage.count);
        IF cardusage.count = 0 THEN
            --�Ŵ� 1�� ���� (�̹��� ���ݾ��� ���ٸ�)
            dbms_output.put_line('�̹��� ���ݾ��� ���ٸ�');        
            SELECT card_id
                INTO out_card_id
            FROM membercard
            WHERE member_id = 'user001'
                ORDER BY DBMS_RANDOM.VALUE
                FETCH FIRST 1 ROW ONLY;
            dbms_output.put_line('������ ī�� ID�� ' || out_card_id);
        ELSE 
            v_card_number := cardusage.first;
            WHILE v_card_number IS NOT NULL LOOP
            -- �÷����� �ش� �ε����� �����ϴ��� Ȯ��
            IF cardusage.EXISTS(v_card_number) THEN
                dbms_output.put_line('2');
                dbms_output.put_line('Card Number: '
                                     || v_card_number
                                     || ', Total Amount: '
                                     || cardusage(v_card_number));

                --ī�� ��ȣ�� �̹� ��뷮�� �ϳ� �̾Ƽ� �� ī���ȣ�� ī������� �񱳽���
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
                                             || ' : price ����Ʈ');
                            IF ( cardusage(v_card_number) - v_performance_list(i) < 0 ) THEN
                                v_findmin_list.extend;
                                v_findmin_list(v_findmin_list.last) := v_performance_list(i);
                            ELSE
                                dbms_output.put_line('������ä��');
                                v_findmin_list.extend;
                                v_findmin_list(v_findmin_list.last) := 9999999;
                            END IF;

                        END LOOP;

                        FOR j IN v_findmin_list.first..v_findmin_list.last LOOP
                            dbms_output.put_line(v_findmin_list(j)
                                             || ' : v_findmin_list�� ��');
                            -- ���� ���� �ּҰ����� ������ �ּҰ��� �ε����� ����
                            IF v_findmin_list(j) < v_min_performance THEN
                                v_min_performance := v_findmin_list(j);
                                v_min_performance_index := j;
                            END IF;

                        END LOOP;
                            -- �ּҰ��� �ε��� ���
                        dbms_output.put_line('�ּҰ��� �ε���: ' || v_min_performance_index);
                        dbms_output.put_line('�ּҰ�: ' || v_min_performance);
                        v_resultperformance_map(v_card_number) := v_min_performance - cardusage(v_card_number);
                        dbms_output.put_line('ī���ȣ: '
                                         || v_card_number
                                         || '�� ��������� ���� �ʿ��� ��: '
                                         || v_resultperformance_map(v_card_number));

                        v_findmin_list.DELETE;
                        v_min_performance := 9999999999; --�ּڰ� ã�� ���� �ٽ� �ʱ�ȭ
                        v_performance_list.DELETE; -- ����Ʈ �ʱ�ȭ
                    END;

                    v_card_number := cardusage.next(v_card_number);
                ELSE
                    v_card_number := v_card_number + 1; -- �������� �ʴ� �ε����� �ǳʶٰ� ���� �ε����� �̵�
                END IF;
            END LOOP;
        --������ ī����� ��������� ���� �ʿ��� �� ����� map ���
        v_card_number := v_resultperformance_map.first;
        WHILE v_card_number IS NOT NULL LOOP
            IF v_resultperformance_map.EXISTS(v_card_number) THEN
                dbms_output.put_line('v_resultperformance_map ���');
                dbms_output.put_line('v_resultperformance_map(v_card_number)�� v_card_number�� '
                                     || v_card_number
                                     || '���� '
                                     || v_resultperformance_map(v_card_number));
                                     -- �ּҰ� ����
                IF v_min_value_performance IS NULL OR v_resultperformance_map(v_card_number) < v_min_value_performance THEN
                    v_min_value_performance := v_resultperformance_map(v_card_number);
                    v_min_index_performance := v_card_number; -- �ּҰ��� ���� ī�� ��ȣ ������Ʈ
                END IF;
                v_card_number := v_resultperformance_map.next(v_card_number);
            END IF;
        END LOOP;

        IF v_min_index_performance IS NOT NULL THEN
            dbms_output.put_line('�ּҰ��� ���� ī�� ��ȣ�� ' || v_min_index_performance);
        ELSE
            dbms_output.put_line('ī�� ��ȣ�� �����ϴ�.');
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
        dbms_output.put_line('������ ����');
        FOR i IN v_benefit_results.first..v_benefit_results.last LOOP
            BEGIN
                    dbms_output.put_line('�ϳ��� ������ ���� �߰����� �� benefit_list�� �ֱ�');
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
                                            AND INSTR('����������', benefit_store_name) > 0; 
                                END;
                   END;

            dbms_output.put_line('v_benefit_list(i)�� ����ID��: ' || v_benefit_list(i).benefit_id);
            dbms_output.put_line('v_benefit_list(i)�� ����card_performance��: ' || v_benefit_list(i).card_performance);
            dbms_output.put_line('�ŷ����� ��ȸ�ؼ� ���� �ѵ� üũ, �� ������ ��� �޾Ҵ� �� üũ');
            v_benefitcount := 0;
            dbms_output.put_line('�ʱ� count��' || v_benefitcount);
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
                AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date); -- �̹� �� �ŷ� ������ ���;
            dbms_output.put_line('�̹��޿� �� ���� ���� Ƚ��' || v_benefitcount);
            IF substr(v_benefit_list(i).benefit_code, 1, 2) = 'DC' THEN
                dbms_output.put_line('�ش� ������ ����� �����̶��');
                dbms_output.put_line('�ش� ������ �ѵ�' || v_benefit_list(i).benefit_max);
                IF substr(v_benefit_list(i).benefit_code, 4, 1) = 'C' THEN
                    IF v_benefitcount < v_benefit_list(i).benefit_max THEN
                        IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'V' THEN
                            v_price := p_price - v_benefit_list(i).benefit_amount;
                            dbms_output.put_line('Price : ' || v_price);
                        ELSIF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                            v_price := p_price - ( p_price * v_benefit_list(i).benefit_amount / 100 );
                        END IF;

                    ELSE
                        dbms_output.put_line('�ش� ������ �ѵ��� �ʰ��ߴ�');
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
                    
                        dbms_output.put_line('transaction_id_list�� count: ' || v_transaction_id_list.count);
                    END;

                    dbms_output.put_line('���� ������ ������ �ŷ� ����Ʈ count: ' || v_transaction_price_list.count);                    
                    --���� ���� �ѵ� �ݾ� �Ѿ��� �� �������� 
                    --�ŷ��ݾ� ����Ʈ ���̸�ŭ �ϴ� ���� ��������
                    --�̹� ������ ù��° ������ ���� �ŷ��� �ƴ϶�� for �� loop ����
                    IF v_transaction_price_list.count != 0 THEN
                        FOR j IN v_transaction_price_list.first..v_transaction_price_list.last LOOP
                        dbms_output.put_line('v_transaction_price_list ���� ����');
                            --���� �ݾ� ���� ���� �ʱ�ȭ 
                            v_origin_price := 0;
                             --�ŷ����� ���� �ݾ� 
                             --v_origin_price := v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100);                      
                            --BEGIN
                             dbms_output.put_line(substr(v_benefit_list(i).benefit_code, 3, 1));
                             dbms_output.put_line(v_benefit_list(i).benefit_amount/100);
                             dbms_output.put_line((1- v_benefit_list(i).benefit_amount/100));
                             dbms_output.put_line(v_transaction_price_list(j));
                             dbms_output.put_line(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                                    --v_transaction_price_list(i)�� ���� �ݾ� 
                                    IF (1- v_benefit_list(i).benefit_amount/100) <> 0 THEN
                                        v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                        dbms_output.put_line('�и� 0�� �ƴ�.');
                                    ELSE
                                        -- 0���� �������� �õ��� ���� ���� ���� ó��
                                        dbms_output.put_line('�и� 0��.');
                                        -- �ʿ��� ���, �ٸ� ��ġ�� ���Ͻʽÿ�.
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
                    dbms_output.put_line('�̹��� ���� ���� �ѵ� : ' || v_benefitMaxValue);
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
--                -- v_price ���� v_price_list VARRAY�� �߰�
--                v_price_list.extend(1); -- VARRAY ũ�� Ȯ��
--                v_price_list(v_price_list.count) := v_price; -- VARRAY�� price �߰�
                END IF;

                dbms_output.put_line('���� ������ �ش� ������ ����Ʈ�� �߰��� ��' || v_price);
                v_price_list.extend(1); -- VARRAY ũ�� Ȯ��
                v_price_list(v_price_list.count) := v_price; -- VARRAY�� price �߰�
            ELSIF substr(v_benefit_list(i).benefit_code, 1, 2) = 'AC' THEN
                dbms_output.put_line('�ش� ������ ����� �����̶��');
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
--                        dbms_output.put_line('transaction_id_list�� count: ' || v_transaction_id_list.count);
--                    END;
--                    dbms_output.put_line('���� ������ ������ �ŷ� ����Ʈ count: ' || v_transaction_price_list.count);                    
--                    --���� ���� �ѵ� �ݾ� �Ѿ��� �� �������� 
--                    --�ŷ��ݾ� ����Ʈ ���̸�ŭ �ϴ� ���� ��������
--                    --�̹� ������ ù��° ������ ���� �ŷ��� �ƴ϶�� for �� loop ����
--                    IF v_transaction_price_list.count != 0 THEN
--                        FOR j IN v_transaction_price_list.first..v_transaction_price_list.last LOOP
--                        dbms_output.put_line('v_transaction_price_list ���� ����');
--                            --���� �ݾ� ���� ���� �ʱ�ȭ 
--                            v_origin_price := 0;
--                             --�ŷ����� ���� �ݾ� 
--                             v_origin_price := v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100);                      
--                            --BEGIN
--                             dbms_output.put_line(substr(v_benefit_list(i).benefit_code, 3, 1));
--                             dbms_output.put_line(v_benefit_list(i).benefit_amount/100);
--                             dbms_output.put_line((1- v_benefit_list(i).benefit_amount/100));
--                             dbms_output.put_line(v_transaction_price_list(j));
--                             dbms_output.put_line(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
--                             dbms_output.put_line(ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100)));
--                                IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
--                                    --v_transaction_price_list(i)�� ���� �ݾ� 
--                                    IF (1- v_benefit_list(i).benefit_amount/100) <> 0 THEN
--                                        v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
--                                         dbms_output.put_line('�и� 0�� �ƴ�.');
--                                    ELSE
--                                        -- 0���� �������� �õ��� ���� ���� ���� ó��
--                                        dbms_output.put_line('�и� 0��.');
--                                        -- �ʿ��� ���, �ٸ� ��ġ�� ���Ͻʽÿ�.
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
--                    dbms_output.put_line('�̹��� ���� ���� �ѵ� : ' || v_benefit_list(i).benefit_max);
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
                        dbms_output.put_line('�ش� ������ �ѵ��� �ʰ��ߴ�');
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
                    
                        dbms_output.put_line('transaction_id_list�� count: ' || v_transaction_id_list.count);
                    END;

                    dbms_output.put_line('���� ������ ������ �ŷ� ����Ʈ count: ' || v_transaction_price_list.count);                    
                    --���� ���� �ѵ� �ݾ� �Ѿ��� �� �������� 
                    --�ŷ��ݾ� ����Ʈ ���̸�ŭ �ϴ� ���� ��������
                    --�̹� ������ ù��° ������ ���� �ŷ��� �ƴ϶�� for �� loop ����
                    IF v_transaction_price_list.count != 0 THEN
                        FOR j IN v_transaction_price_list.first..v_transaction_price_list.last LOOP
                        dbms_output.put_line('v_transaction_price_list ���� ����');
                            --���� �ݾ� ���� ���� �ʱ�ȭ 
                            v_origin_price := 0;
                             --�ŷ����� ���� �ݾ� 
                             --v_origin_price := v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100);                      
                            --BEGIN
                             dbms_output.put_line(substr(v_benefit_list(i).benefit_code, 3, 1));
                             dbms_output.put_line(v_benefit_list(i).benefit_amount/100);
                             dbms_output.put_line((1- v_benefit_list(i).benefit_amount/100));
                             dbms_output.put_line(v_transaction_price_list(j));
                             dbms_output.put_line(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                IF substr(v_benefit_list(i).benefit_code, 3, 1) = 'P' THEN
                                    --v_transaction_price_list(i)�� ���� �ݾ� 
                                    IF (1- v_benefit_list(i).benefit_amount/100) <> 0 THEN
                                        v_origin_price := ROUND(v_transaction_price_list(j) / (1- v_benefit_list(i).benefit_amount/100));
                                        dbms_output.put_line('�и� 0�� �ƴ�.');
                                    ELSE
                                        -- 0���� �������� �õ��� ���� ���� ���� ó��
                                        dbms_output.put_line('�и� 0��.');
                                        -- �ʿ��� ���, �ٸ� ��ġ�� ���Ͻʽÿ�.
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
                    dbms_output.put_line('�̹��� ���� ���� �ѵ� : ' || v_benefitMaxValue);
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
--                -- v_price ���� v_price_list VARRAY�� �߰�
--                v_price_list.extend(1); -- VARRAY ũ�� Ȯ��
--                v_price_list(v_price_list.count) := v_price; -- VARRAY�� price �߰�
                END IF;
                dbms_output.put_line('���� ������ �ش� ������ ����Ʈ�� �߰��� ��' || v_price);
                v_price_list.extend(1); -- VARRAY ũ�� Ȯ��
                v_price_list(v_price_list.count) := v_price; -- VARRAY�� price �߰�
            END IF;

        END LOOP;

        -- VARRAY �ȿ��� �ּڰ� �� �ش� �ε��� ã��
        FOR i IN v_price_list.first..v_price_list.last LOOP
            dbms_output.put_line('v_price_list(i): ' || v_price_list(i));
            IF v_price_list(i) < v_min_value OR v_min_value IS NULL THEN
                v_min_value := v_price_list(i); -- �ּڰ� ����
                v_min_index := i; -- �ּڰ��� �ε��� ����
            END IF;

        END LOOP;

        -- �ּڰ� �� �ش� �ε��� ���
        dbms_output.put_line('Min Value: ' || v_min_value);
        dbms_output.put_line('Min Index: ' || v_min_index);
        -- �ּڰ��� ���� v_benefit_results�� card_id�� ����

        IF v_min_index IS NOT NULL THEN
            out_card_id := v_benefit_list(v_min_index).card_id;
            dbms_output.put_line('��� card_id: ' || out_card_id);
        END IF;

    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Exception �߻�: ' || sqlerrm);
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
    v_price NUMBER := 0; -- �Ǵ� �ٸ� �⺻������ �ʱ�ȭ

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
        AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date); -- �̹� �� �ŷ� ������ ���

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
                END IF; -- �� END IF�� �߰���
            END IF; -- �� END IF�� �߰���
        ELSIF SUBSTR(v_benefit.benefitCode, 1, 2) = 'AC' THEN
            -- 'AC' ���� ����: ������ ������� �����Ƿ� ������ ó�� ���� �Ʒ��� �ŷ� ���� �߰��� �Ѿ
              v_price := p_price; 
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('���� ����');
            v_price := p_price;

    END;

    -- At the end, insert the transaction
    INSERT INTO transactionhistory (transaction_date,transaction_amount, card_number, member_id, transaction_industry_code, transaction_store_name)
    VALUES (p_date, v_price, v_card_number, p_member_id, p_storeCategoryCode, p_storeName)
    RETURNING transaction_id INTO OUT_TRANSACTION_ID;

END SP_SUBMIT_PAYMENT;

/


commit;
