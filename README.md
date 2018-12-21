# ns3-docker

Docker image for NS-3 Network Simulator with GUI Support on OSX

## Usage

Clone the repo then run:
```make```
This will download the ns3 version 3.26 and build the docker image for you.

If you don't want the ns3 src files in the host machine for development you can download ns3 inside the image by replacing the line `COPY . /usr` in Dockerfile with these lines:
```
RUN wget http://www.nsnam.org/release/ns-allinone-3.26.tar.bz2
RUN tar -xf ns-allinone-3.26.tar.bz2
```

### GUI prerequisites & steps for macOS:

1. `brew install socat`
2. `brew cask install xquartz`
3. `open -a XQuartz`
4. `make run`
5. `cd ns3/ns-3.26`
6. `./waf configure`
  > 
  ```
  ---- Summary of optional NS-3 features:
  Build profile                 : debug
  Build directory               :
  BRITE Integration             : not enabled (BRITE not enabled (see option --with-brite))
  DES Metrics event collection  : not enabled (defaults to disabled)
  Emulation FdNetDevice         : enabled
  Examples                      : not enabled (defaults to disabled)
  File descriptor NetDevice     : enabled
  GNU Scientific Library (GSL)  : enabled
  Gcrypt library                : not enabled (libgcrypt not found: you can use libgcrypt-config to find its location.)
  GtkConfigStore                : enabled
  MPI Support                   : not enabled (option --enable-mpi not selected)
  NS-3 Click Integration        : not enabled (nsclick not enabled (see option --with-nsclick))
  NS-3 OpenFlow Integration     : not enabled (OpenFlow not enabled (see option --with-openflow))
  Network Simulation Cradle     : not enabled (NSC not found (see option --with-nsc))
  PlanetLab FdNetDevice         : not enabled (PlanetLab operating system not detected (see option --force-planetlab))
  PyViz visualizer              : enabled
  Python API Scanning Support   : not enabled (Missing 'pygccxml' Python module)
  Python Bindings               : enabled
  Real Time Simulator           : enabled
  SQlite stats data output      : enabled
  Tap Bridge                    : enabled
  Tap FdNetDevice               : enabled
  Tests                         : not enabled (defaults to disabled)
  Threading Primitives          : enabled
  Use sudo to set suid bit      : not enabled (option --enable-sudo not selected)
  XmlIo                         : enabled
  'configure' finished successfully (4.609s)
  ```

To make sure that it works, in the container run:
1. `cd /usr/ns3/ns-3.26/scratch`
2. ` mkdir example`
3. `cp ./../examples/tutorial/second.cc example/`
4. `cd ..`
5. `./waf --run example --vis`
  it should compile then run the visualization in xQuartz.
  
### Troubleshooting
1. Make sure you allow connetions from network clients in XQuartz (Preferences -> Security)
2. Make sure that local xquartz socket is exposed on a TCP port. `lsof -i TCP:6000`
3. Check this thread https://github.com/moby/moby/issues/8710
  
