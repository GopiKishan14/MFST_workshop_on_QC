namespace Qsharp {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    

    operation HelloQ() : Unit {
        Message("Hello quantum world!");
        using(qubit = Qubit())
        {
            H(qubit);
            let result = M(qubit);
            Message($"Measurement is {result}");


            // if(result ==One)
            // {
            //     Message("Result is One");
            // }
            // else
            // {
            //     Message("Result is zero");
            // }
            Reset(qubit);
             
        }

    }


    operation MultiGateQ() : Unit {
        Message("Hello quantum world!");

        using(qubits = Qubit[10])
        {

            for(q in qubits)
            {
                H(q);
            }
            let result = MultiM(qubits);
            Message($"Measurement is {result}");
            
            ResetAll(qubits);
             
        }

    }

    operation HalfAdder() : Unit {
        Message("Hello quantum world!");

        using(qubits = Qubit[3])
        {

            CCNOT(qubits[0], qubits[1], qubits[2]);
            CNOT(qubits[0], qubits[1]);
            let result = MultiM(qubits);
            Message($"Measurement is {result}");
            
            ResetAll(qubits);
             
        }

    }


    operation Deutsch(i:String) : Unit {

        using(q = Qubit[2])
        {
            X(q[1]);

            H(q[0]);
            H(q[1]);

            if(i=="0")
            {
                // // -> const 0
            }
            elif(i=="1")
            {
                X(q[1]); // -> const 1
            }
            elif(i=="2")
            {
                CNOT(q[0], q[1]); // -> balanced same
            }
            else{
                CNOT(q[0], q[1]); X(q[1]); // -> balanced invert
            }

            

            
            H(q[0]);

            let result = M(q[0]);
            if (result == Zero) {
                Message($"Function is Constant");
            } else {
                Message($"Function is Balanced");
            }
            ResetAll(q);
             
        }

    }



    operation Deutsch_Jozsa(i:String) : Unit {

        using((inp_q , out_q) = (Qubit[4], Qubit()))
        {
            X(out_q);

            ApplyToEach(H, inp_q);
            H(out_q);

            // H(q[0]);
            // H(q[1]);

            if(i=="0")
            {
                // // -> const 0
            }
            elif(i=="1")
            {
                X(out_q); // -> const 1
            }
            elif(i=="2")
            {
                CNOT(inp_q[0], out_q); // -> balanced same
            }
            else{
                CNOT(inp_q[0], out_q); X(out_q); // -> balanced invert
            }

            
            ApplyToEach(H, inp_q);
            
            // H(q[0]);

            let result = MultiM(inp_q);
            let ans = ResultArrayAsInt(result);

            if (ans==0) {
                Message($"Function is Constant");
            } else {
                Message($"Function is Balanced");
            }
            ResetAll(inp_q);
            Reset(out_q);
             
        }

    }


    operation Simon() : Unit {

        using((x , y) = (Qubit[2], Qubit[2]))
        {
            for(i in 0..5)
            {
            // s = 01
            // 00 -> 01
            X(x[0]);
            X(x[1]);
            Controlled X(x , y[0]);
            X(x[0]);
            X(x[1]);
            // 01 -> 01
            X(x[0]);
            // X(x[1]);
            Controlled X(x , y[0]);
            X(x[0]);
            // X(x[1]);


            // 10 -> 10
            // X(x[0]);
            X(x[1]);
            Controlled X(x , y[1]);
            // X(x[0]);
            X(x[1]);

            // 11 -> 10
            Controlled X(x , y[1]);

            let y_res = MultiM(y);
            let x_res = MultiM(x);

            Message($"Result is {y_res}");

            ResetAll(x);
            ResetAll(y);
            }
             
        }

    }



    operation Grover() : Unit {

        using((x , y, z) = (Qubit[4], Qubit(), Qubit[4]))
        {

            
            ApplyToEach(H, x);
            X(y); 
            H(y);
            for(i in 0..8)
            {


                // 0101
                X(x[0]);
                X(x[2]);
                Controlled X(x , y);
                X(x[0]);
                X(x[2]);


                ApplyToEach(H, x);
                X(x[0]);
                X(x[1]);
                X(x[2]);
                X(x[3]);
                // X(y);
                Controlled X(x , y);
                X(x[0]);
                X(x[1]);
                X(x[2]);
                X(x[3]);
                ApplyToEach(H, x);

                DumpRegister(() , x);
            }

            let x_res = MultiM(x);
         

            Message($"Result is {x_res}");

            ResetAll(x);
            ResetAll(z);
            Reset(y);
             
        }

    }



}

