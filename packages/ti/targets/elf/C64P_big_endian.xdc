/* 
 *  Copyright (c) 2009 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 * 
 *  Contributors:
 *      Texas Instruments - initial implementation
 * 
 * */

/*
 *  ======== C64P_big_endian.xdc ========
 *
 */

/*!
 *  ======== C64P_big_endian ========
 *  TI C64P big endian target
 */
metaonly module C64P_big_endian inherits ITarget {
    override readonly config string name                 = "C64P_big_endian";
    override readonly config string suffix               = "e64Pe";
    override readonly config string isa                  = "64P"; 
    override readonly config xdc.bld.ITarget.Model model = {
        endian: "big",
        shortEnums: true
    };
    override readonly config xdc.bld.ITarget.Module base = ti.targets.C62;

    override readonly config string rts = "ti.targets.rts6000";
    override config string platform     = "ti.platforms.sim6xxx:TMS320CDM420";
    
    override readonly config ti.targets.ITarget.Command ar = {
        cmd: "ar6x",
        opts: "rq"
    };

    override readonly config ti.targets.ITarget.Command cc = {
        cmd: "cl6x -c",
        opts: "-me -mv64p --abi=elfabi"
    };

    override readonly config ti.targets.ITarget.Command vers = {
        cmd: "cl6x",
        opts: "-version"
    };

    override readonly config ti.targets.ITarget.Command asm = {
        cmd: "cl6x -c",
        opts: "-me -mv64p --abi=elfabi"
    };

    override readonly config ti.targets.ITarget.Command lnk = {
        cmd: "lnk6x",
        opts: "--abi=elfabi"
    };

    /*!
     *  ======== asmOpts ========
     *  User configurable assembler options.
     *
     *  Defaults:
     *  @p(dlist)
     *      -`-qq`
     *          super quiet mode
     */
    override config ti.targets.ITarget.Options asmOpts = {
        prefix: "-qq",
        suffix: ""
    };

    /*!
     *  ======== ccOpts ========
     *  User configurable compiler options.
     *
     *  Defaults:
     *  @p(dlist)
     *      -`-qq`
     *          super quiet mode
     *      -`-pdsw225`
     *          generate a warning for implicitly declared functions; i.e.,
     *          functions without prototypes
     */
    override config ti.targets.ITarget.Options ccOpts = {
        prefix: "-qq -pdsw225",
        suffix: ""
    };

    /*!
     *  ======== ccConfigOpts ========
     *  User configurable compiler options for the generated config C file.
     *
     *  -mo places all functions into subsections
     *  --no_compress helps with compile time with no real difference in
     *  code size since the generated config.c is mostly data and small
     *  function stubs
     */
    override config ti.targets.ITarget.Options ccConfigOpts = {
        prefix: "$(ccOpts.prefix) -mo --no_compress",
        suffix: "$(ccOpts.suffix)"
    };

    /*!
     *  ======== lnkOpts ========
     *  User configurable linker options.
     *
     *  Defaults:
     *  @p(dlist)
     *      -`-w`
     *          Display linker warnings
     *      -`-q`
     *          Quite run
     *      -`-u`
     *          Place unresolved external symbol into symbol table
     *      -`-c`
     *          ROM autoinitialization model
     *      -`-m`
     *          create a map file
     *      -`-l`
     *          archive library file as linker input
     */
    override config ti.targets.ITarget.Options lnkOpts = {
        prefix: "-w -q -u _c_int00",
        suffix: "-c -m $(XDCCFGDIR)/$@.map -l $(rootDir)/lib/rts64pluse_elf.lib"
    };
        
    override config string includeOpts = "-I$(rootDir)/include";

    override readonly config Int bitsPerChar = C64P.bitsPerChar;
}
/*
 *  @(#) ti.targets.elf; 1, 0, 0,152; 2-24-2010 16:24:19; /db/ztree/library/trees/xdctargets/xdctargets-b36x/src/
 */

