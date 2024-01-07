#include <iostream>
#include <chrono>
using namespace std;

class Timer{

public:
  Timer(double* accumulator)
  {
    acc = accumulator;
    m_StartTimepoint = std::chrono::high_resolution_clock::now();
  }

  ~Timer()
  {
    Stop();
  }

  void Stop()
  {
    auto endTimepoint = std::chrono::high_resolution_clock::now();

    auto start = std::chrono::time_point_cast<std::chrono::microseconds>(m_StartTimepoint).time_since_epoch().count();
    auto end = std::chrono::time_point_cast<std::chrono::microseconds>(endTimepoint).time_since_epoch().count();
    auto duration = end-start;
    double ms = duration*0.001;
    if(acc != nullptr) {
      (*acc) += ms;
    }
  }
private:
  double* acc = nullptr;
  std::chrono::time_point<std::chrono::high_resolution_clock> m_StartTimepoint;
};

int main()
{
    cerr << "libros tiempo\n";

    int c = 5;
    int lim = 60;
    int step = 5;

    int n1,n2,n3;
    n1=1234;
    n2=999;
    n3=600006;

    while(c <= lim)
    {
        double t1 = 0;
        cerr << c << " ";
        {
            string com = "timeout 300s ff -O -o ../domain-ext2.pddl -f ./juegos/prueba" + to_string(c) + "-" + to_string(n1) + ".pddl";
            const char* comC = com.c_str();
            Timer t(&t1);
            system(comC);
        }
        cerr << t1 << "\n";
        n1+=step;

        t1 = 0;
        cerr << c << " ";
        {
            string com = "timeout 300s ff -O -o ../domain-ext2.pddl -f ./juegos/prueba" + to_string(c) + "-" + to_string(n2) + ".pddl";
            const char* comC = com.c_str();
            Timer t(&t1);
            system(comC);
        }
        cerr << t1 << "\n";
        n2+=step;

        t1 = 0;
        cerr << c << " ";
        {
            string com = "timeout 300s ff -O -o ../domain-ext2.pddl -f ./juegos/prueba" + to_string(c) + "-" + to_string(n3) + ".pddl";
            const char* comC = com.c_str();
            Timer t(&t1);
            system(comC);
        }
        cerr << t1 << "\n";
        n3+=step;

        c+=step;
    }
}