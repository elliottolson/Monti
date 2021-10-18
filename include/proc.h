#ifndef proc_h
#define proc_h

enum state {
    NEW, READY, RUNNING, WAITING, TERMINATED
};

struct process {
    long pid;
    enum state state;
    
    struct process *parent;
};

struct cpu {
    struct process *process;
};

#endif
