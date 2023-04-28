`timescale 1ps/1ps

/* teste do somador de um bit */
module half_adder_test ();
    reg cin;
    reg a;
    reg b;
    wire sum;
    wire cout;

    half_adder uut(
        .cin(cin),
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $monitor("cin | a | b | sum | cout\n------------------------");
        #100;

        cin = 1'b0;
        a = 1'b0;
        b = 1'b0;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;

        cin = 1'b0;
        a = 1'b0;
        b = 1'b1;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;

        cin = 1'b0;
        a = 1'b1;
        b = 1'b0;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;

        cin = 1'b0;
        a = 1'b1;
        b = 1'b1;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;

        cin = 1'b1;
        a = 1'b0;
        b = 1'b0;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;

        cin = 1'b1;
        a = 1'b0;
        b = 1'b1;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;

        cin = 1'b1;
        a = 1'b1;
        b = 1'b0;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;

        cin = 1'b1;
        a = 1'b1;
        b = 1'b1;
        $monitor("  %B | %B | %B |  %B  | %B", 
            cin,
            a,
            b,
            sum,
            cout
        );
        #100;
    end

endmodule //half_adder