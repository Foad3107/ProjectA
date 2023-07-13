simSetSimulator "-vcssv" -exec \
           "./build/lowrisc_ibex_ibex_simple_system_0/sim-vcs/lowrisc_ibex_ibex_simple_system_0" \
           -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" \
          "./build/lowrisc_ibex_ibex_simple_system_0/sim-vcs/lowrisc_ibex_ibex_simple_system_0.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "209" "89" "1440" "752"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBRunSim
debExit
