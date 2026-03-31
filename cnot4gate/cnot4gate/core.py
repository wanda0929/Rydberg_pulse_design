"""
Core functionality for CNOT4 gate operations.
"""


import numpy as np
from qutip import *
import matplotlib.pyplot as plt
from typing import Union
from qutip import basis

#parameters
omega_r = 2 * np.pi * 50 #MHz
omega_max = omega_r
omega_c = 2.5 * omega_r #MHz
Dta = 2 * np.pi * 1200 #MHz
T_p = 16 * np.pi * Dta/(3 * omega_max**2)
T_c = np.pi/omega_r
tmax = T_c * 2 + T_p
V_dd = 2 * np.pi * 500 #MHz
tau_c = 548
tau_p = 0.131
tau_R = 505
gamma_c = 1/tau_c
gamma_p = 1/tau_p
gamma_R = 1/tau_R

#time list
tlist = np.linspace(0, tmax, 1000)

#control atom states
g = basis(3,0) #|0>
e = basis(3,1) #|1>
r = basis(3,2) #|2>

#dagger
g_dag = g.dag()  # <0|
e_dag = e.dag()  # <1|
r_dag = r.dag()  # <2|

#target atom states
A = basis(4,0) 
B = basis(4,1)
P = basis(4,2)
R = basis(4,3)

#dagger
A_dag = A.dag()
B_dag = B.dag()
P_dag = P.dag()
R_dag = R.dag()


#control field
def Omega_c(t):
    if 0<=t<T_c:
        return omega_c
    elif T_c + T_p<=t<=tmax:
        return omega_c
    else:
        return 0


#probe field
def Omega_p(t):
    if T_c<=t<T_c+T_p:
        return omega_max * (np.sin(np.pi * (t-T_c)/T_p))**2
    else:
        return 0



#hc = np.array([[0, 0, 0],
#               [0, 0, omega_c/2],
#               [0, omega_c/2, 0]])

#hrr = np.array([[0, 0, 0],
#                [0, 0, 0],
#                [0, 0, 1]])

#hRR = np.array([[0, 0, 0, 0],
#                [0, 0, 0, 0],
#                [0, 0, 0, 0],
#                [0, 0, 0, 1]])

#hamiltonian
hc = omega_c/2 * (e * r_dag + r * e_dag)
hrr = r * r_dag
hRR = R * R_dag

#ht = np.array([[0, 0, Omega_p(t)/2, 0],
#                     [0, 0, Omega_p(t)/2, 0],
#                     [Omega_p(t)/2, Omega_p(t)/2, -Dta, Omega_c(t)/2],
#                     [0, 0, Omega_c(t)/2, 0]])

def ht(t):
    return Omega_p(t)/2 * (P * A_dag + A * P_dag + P * B_dag + B * P_dag) + Omega_c(t)/2 * (P * R_dag + R * P_dag) - Dta * P * P_dag

#dissipation operators
L_c = np.sqrt(gamma_c) * (g * r_dag + e * r_dag)
L_P = np.sqrt(gamma_p) * (A * P_dag + B * P_dag)
L_R = np.sqrt(gamma_R) * (A * R_dag + B * R_dag)

#non-hermitian hamiltonian
def Hnhermitian(t):
    h1 = tensor(hc, np.eye(4)) + tensor(np.eye(3), ht(t))
    h2 = V_dd * tensor(hrr, hRR)
    h3 = -1j/2 * (L_c.dag() * L_c + L_P.dag() * L_P + L_R.dag() * L_R)
    return h1 + h2 + h3

#dissipation operators
# Qobj(L_c)
c_ops = tensor(L_c, Qobj(np.eye(4))) + tensor(Qobj(np.eye(3)), L_P) + tensor(Qobj(np.eye(3)), L_R)

#initial state
psi_0 = tensor(g,A)

psi_1 = tensor(g,B)

mc = mcsolve(Hnhermitian, psi_0, tlist, c_ops, [psi_0*psi_0.dag(), psi_1*psi_1.dag()])

Hnhermitian

print(mc.expect[0][999])

plt.plot(tlist,mc.expect[0],lw=2)

plt.show()







 