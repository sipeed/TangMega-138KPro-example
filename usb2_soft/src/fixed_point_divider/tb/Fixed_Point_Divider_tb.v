
`timescale 1ns/1ps
module testbench () ;
    parameter N = 32 ; 
    parameter Q = 3 ; 
    integer a = ($random % (2 ** (N - 1))) ; 
    integer b = ($random % (2 ** (N - 1))) ; 
    integer c = ($random % (2 ** (N - 1))) ; 
    integer d = ($random % (2 ** (N - 1))) ; 
    reg clk ; 
    reg start ; 
    reg signed [(N - 1):0] dividend ; 
    reg signed [(N - 1):0] divisor ; 
    wire signed [(N - 1):0] quotient_out ; 
    wire complete ; 
    real deviation ; 
    reg signed [(N - 1):0] quotient ; 
    real dividend_golden ; 
    real divisor_golden ; 
    real true_result ; 
    real IP_result ; 
    real real_quotient ; 
    integer file_out ; 
    GSR GSR (.GSRI(1'b1)) ; 
    always
        begin
            #(10) clk = (~clk) ;
        end
    always
        @(complete)
        begin
            true_result = (dividend_golden / divisor_golden) ;
            if (((dividend_golden < 0) && (divisor_golden > 0))) 
                begin
                    quotient[(N - 1)] = quotient_out[(N - 1)] ;
                    quotient[(N - 2):0] = ((~quotient_out[(N - 2):0]) + 1) ;
                    real_quotient = quotient ;
                    IP_result = (real_quotient / (2 ** Q)) ;
                    deviation = (true_result - IP_result) ;
                end
            else
                if (((dividend_golden > 0) && (divisor_golden > 0))) 
                    begin
                        quotient = quotient_out ;
                        real_quotient = quotient ;
                        IP_result = (real_quotient / (2 ** Q)) ;
                        deviation = (true_result - IP_result) ;
                    end
            if (((dividend_golden > 0) && (divisor_golden < 0))) 
                begin
                    quotient[(N - 1)] = quotient_out[(N - 1)] ;
                    quotient[(N - 2):0] = ((~quotient_out[(N - 2):0]) + 1) ;
                    real_quotient = quotient ;
                    IP_result = (real_quotient / (2 ** Q)) ;
                    deviation = (true_result - IP_result) ;
                end
            else
                if (((dividend_golden < 0) && (divisor_golden < 0))) 
                    begin
                        quotient = quotient_out ;
                        real_quotient = quotient ;
                        IP_result = (real_quotient / (2 ** Q)) ;
                        deviation = (true_result - IP_result) ;
                    end
            if ((complete == 1)) 
                begin
                    $fdisplay (file_out,"finish\n dividend=%f divisor=%f quotient_out=%f golden_number=%f deviation=%f\n N=%d Q=%d",dividend_golden,divisor_golden,IP_result,true_result,deviation,N,Q) ;
                end
        end
    initial
        begin
            start = 1 ;
            clk = 1 ;
            dividend_golden = a ;
            divisor_golden = b ;
            if (((a > 0) && (b > 0))) 
                begin
                    dividend[(N - 1)] = a[31] ;
                    dividend[(N - 2):0] = a[(N - 2):0] ;
                    divisor[(N - 1)] = b[31] ;
                    divisor[(N - 2):0] = b[(N - 2):0] ;
                end
            else
                if (((a < 0) && (b > 0))) 
                    begin
                        dividend[(N - 1)] = a[31] ;
                        dividend[(N - 2):0] = ((~a[(N - 2):0]) + 1) ;
                        divisor[(N - 1)] = b[31] ;
                        divisor[(N - 2):0] = b[(N - 2):0] ;
                    end
                else
                    if (((a > 0) && (b < 0))) 
                        begin
                            divisor[(N - 1)] = b[31] ;
                            divisor[(N - 2):0] = ((~b[(N - 2):0]) + 1) ;
                            dividend[(N - 1)] = a[31] ;
                            dividend[(N - 2):0] = a[(N - 2):0] ;
                        end
                    else
                        if (((a < 0) && (b < 0))) 
                            begin
                                divisor[(N - 1)] = b[31] ;
                                divisor[(N - 2):0] = ((~b[(N - 2):0]) + 1) ;
                                dividend[(N - 1)] = a[31] ;
                                dividend[(N - 2):0] = ((~a[(N - 2):0]) + 1) ;
                            end
            #(20) start = 0 ;
            file_out = $fopen("../../doc/data.txt","w") ;
            #(1500) start = 1 ;
            dividend_golden = c ;
            divisor_golden = d ;
            if (((c > 0) && (d > 0))) 
                begin
                    dividend[(N - 1)] = c[31] ;
                    dividend[(N - 2):0] = c[(N - 2):0] ;
                    divisor[(N - 1)] = d[31] ;
                    divisor[(N - 2):0] = d[(N - 2):0] ;
                end
            else
                if (((c < 0) && (d > 0))) 
                    begin
                        dividend[(N - 1)] = c[31] ;
                        dividend[(N - 2):0] = ((~c[(N - 2):0]) + 1) ;
                        divisor[(N - 1)] = d[31] ;
                        divisor[(N - 2):0] = d[(N - 2):0] ;
                    end
                else
                    if (((c > 0) && (d < 0))) 
                        begin
                            divisor[(N - 1)] = d[31] ;
                            divisor[(N - 2):0] = ((~d[(N - 2):0]) + 1) ;
                            dividend[(N - 1)] = c[31] ;
                            dividend[(N - 2):0] = c[(N - 2):0] ;
                        end
                    else
                        if (((c < 0) && (d < 0))) 
                            begin
                                divisor[(N - 1)] = d[31] ;
                                divisor[(N - 2):0] = ((~d[(N - 2):0]) + 1) ;
                                dividend[(N - 1)] = c[31] ;
                                dividend[(N - 2):0] = ((~c[(N - 2):0]) + 1) ;
                            end
            #(20) start = 0 ;
            #(1500) $fclose (file_out) ;
            $finish  ;
        end
    Fixed_Point_Divider_Top u1 (.dividend(dividend), .divisor(divisor), .start(start), .clk(clk), .quotient_out(quotient_out), .complete(complete)) ; 
endmodule


