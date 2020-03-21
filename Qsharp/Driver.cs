using System;
using System.Threading.Tasks;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Qsharp
{
    class Driver
    {
        static async Task Main(string[] args)
        {

            // String i = Console.ReadLine();
            using (var qsim = new QuantumSimulator())
            {
                // await HelloQ.Run(qsim);
                // await MultiGateQ.Run(qsim);
                // await HalfAdder.Run(qsim);
                // await Deutsch.Run(qsim, i);
                // await Deutsch_Jozsa.Run(qsim, i);
                // await Simon.Run(qsim);
                await Grover.Run(qsim);
            }
        }
    }
}