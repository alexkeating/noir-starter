// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/zkVote.sol";
import "../src/plonk_vk.sol";

contract zkVoteTest is Test {
    zkVote public voteContract;
    UltraVerifier public verifier;

    function setUp() public {
        verifier = new UltraVerifier();
        voteContract = new zkVote(0x02b54b6daa0b81c12a9d75f44d39e52dcbfa2ef2ab04dbe9159559a547a9ae82, address(verifier));
        voteContract.propose("First proposal", block.timestamp + 10000000);
    }


    function testFailInvalidProof() public {
        bytes32[] memory inputs = new bytes32[](4);
        inputs[0] = 0x02b54b6daa0b81c12a9d75f44d39e52dcbfa2ef2ab04dbe9159559a547a9ae82;
        inputs[1] = bytes32(0);
        inputs[2] = bytes32(abi.encodePacked(uint(1)));
        inputs[3] = 0x00b698152e6728b3ac8d6a4f0465741afb38617dee54c60672038d483d0e7f7b;
        verifier.verify(hex"27fc2773868d67f83891eebaebd03967d4ee17e9ea8a7a0abeb2a67d3f4023045df585eeee245d3d7c159635b00e2a8f669571116d16948012e87a97cfb7f71aa3dddd87f51d0aed91c9771a390dc9b61971f3dcf0c5fc3c53378723dd9d212750784672ae40daf0975357642e209d0a343158dbf1d9aba24e9f811b14dc641802b0d699b98120d112a596c99a0dd3d8faeec58cc872f757fe871492f2bace2eed363cfc3016aff964b5045cefbbcdbfe13fd9feaa690fcfd2215df41ffbeb2d512b248530499fa5e7b9b7eb6f0c07d4b553435e8d1c98dc9984782c403e6e237674f9636dfaf35d37f321b3a3f1a6f10380020e30cf35a6c2707fdd0f750f21f2f3fe5d4f9db8d88ccb6712810a567a214e60215b404ec23a3512d186574d2aa37334db3f08ace933f05a095f85e237d3cac06250c7b975e86575d6f3971c2d6a6abd7fe83b39dc7a5899cab340b01b1f27414ebe57d59353196ed514f15d05433bf0b2943a103dcef5de383a41083348e2dc519e294291ed401abaed51092c167a62ba895320b7eda22f82c0a77d0f1f8821369b5a0c5c032145132415bd2a1c50c977cbeb4cfabf3ff4b7dd9fef50821e0902ed09637f54605d65b0a1f6019a23996d8726ba528d3ff2cfb29bccdd7629f8cdf4d2c1bcc8a9fc5f2560ea080439ebee6d3cea4de43a85b1d9b7d22d93a1e5b3b32281c38d5647aeb7eb3c2406b6ccc2e0d98d22eec28fd23b829ab9d161eb0dcc5271821b8f6e3be8b18f016ff85f8b53a683ad2e67d9bccc3fcaab5219e5b7518d5c27cde426e1c76d88126e675ee8f0bfc624865abb8b7a6df903af98573e146602fd5bb4985a947e641d58fdfd5c2652abca177cc1408f67c6d30fd373f1c91043a57cc6c98b6f6367153f436bc9b1fb6793991c40fee206d9da69f1388c2f7ff659dbef5cd11b1608267c23b7e0b7ac0779ea5a12d83e47ab7b633444893450cb59407e14140dd4a1164e75baa706e7366126513542a4a5a31dbcafacaebaa5153c9d715302da1a2404841e6be30145f2cbf012f2faa98e631191c688b2adcf15d67a74e6017333271bcb68b0773ec68a4072a55a46ef0dbf4318945911ad2c44ccbc9ff63ac621d829884dc1b07053d84662ad4a4044b0d6e3eec3c5d03cd806159bf6bcba19041b06cec6aa2432fbaa3bb766ca0c148bfc01468035cb83a1b1deb2643316e845f1121f3382a35f56077c39d06e16f7625b8b741ae66276fcaf6a422fb7c1a5f62f2fe2b1cc0596bfb99ff1babc0ef6cb02800a1c0d6aebe2f00b6c23157f115af702f7704bac81e31895b95c64bdb66f7339efc85aa09c7edcd4676578736afa0d0a88bcb103afbc0ff1254be0e1bd46db5b0a831fc9a6ac0e47e117612b1e076f028dffd6e06e8e399202d8f5b9acc3db81b9ee29233d4725f20a0d53318f7cbc264183b8b72a7329f6559082324cb95f078a5e75bd1d09259563fa40f282ed4d1a15d7301164eee08e43a5b9e9ac6dcb3f394b1f40d2437d8988b0769eef4592221d6112606962b76db01ea8f9aa4308632ec28cf1ccdf4f0a4c148c40836b5d25cc7df4b3ab21bf286db774a266f78905942a4b9d72f802f65a47425111dce21a5737a32b3ef5fe4607e619195d2942ea2858f22ee93c52cd48cd291056258315b19fa454449c794e06c58159f2c6d0ac95f765bba08fd4d4a1dda32817eb3b23a2f04691b1a3ab4ddc1afa99a1e1fc735dcccfab7490cb2ef8bd71f910a35d1d85621b2709336b4ab5101d01629c72f7d9e8e8acc525b65c47ac4cb4e7c850213196479a89fb1d5f1e4189e81cc533c86837fb57c0d220ae38cbe0c6775afc0c2db06429cb0a55e2f7058cf467eaf663d33afae4e1ab7fa04fad181c338a5b24878c5e9c32a9bb1e560c04d5261c7f4ad4edca8e81693b9933923f3f65ebff0740ecfec2c211b14b1748fe4afa33cd5d139b10013799f8414e42d0a467ec18162bdf930511c461147503a22688065ae765b18c2b2baa4c96b6b9ec5af02e8e1dccf6563ea7d203f6ad949f538a45b7ffe5a844f27abba157ab10fb72a320e71283013f206de301a8843757264f79566cb1c5ad13baa0f7e7a4fc8c11e3a19705c0868b434179b2e04ed03807529e001e9cf071a14570f792594098c47c52b71ce0b17999d22d56317e3decf67134588ddbe9ca8f31c6b09ece615571c8366908ef363c97257e4b649e9810b44078046b24ac09b4685972d6f37876c05414540959177ea70eed539b6de18576b4dd365cc5b7d380bbe54a068f7e1c9e07cad1149f7d4dc6633e7634d9f447d31edf203a19ddddead3e2642979ea603fb118142fdfc869c2c8896ca87fc5aaf0acd0dd6350ee60325850d38f8bc01afce75b57215ce94d14ae6b48dadf0702898d6415de1c4dd22ed6ace670a04c821b42fbcb2e7be3eb86597da311e638bfebcb363f5ae27f52f85246150e98a119c9fc8cf7106e52449e49c60fe7a01ba407b029fd81f2c78f8fd2288436880b3a1c51711105df0098295ab2e7ee76389b87523bbdcc8e0c44de22c5b876038141834f84d701126a3c7c12f84aafe73ac92fdd68088938eb51fe90cbba3122675c20372dea20daa8d858e426cfc927850b8a9f9c4fdd9895df8ecef79a7061c570e4c581342edf20c1c06768896622d9ecb5258ba16c20ac1a9c5d7123e01defb39a0d8bc01dd79610e6377abe3449d5d1f502717130fade9628b28deeb9722768c1b53b1d0cd390ff1ff4b050372e29731fcea189cdadebe5ec41fec30184839f649d0ad026b44d897c15dbcdc190f7ecaa24d2a11b983b54d8a397eea8fc75f2c83542fe02133515785514238dc5917dbcf40b8289430aca0895e2db04df60c7f5b580a92b4b2ef25de1226d9ee36fc5f1dd661eeec801e7a38f5f3c06a8e0a55fb5035129d9b0ef2c1c962825d5579a5b871ea7c9104f28322aa1072e47f5a2f4af3bbd2b4f059b85b69c797d39f3f8f5948287f4626518d00a1ed3347506d78969aa99", inputs);
    }

    function testValidVote() public {
        voteContract.castVote(
            hex"257fc27753868d67f83891eebaebd03967d4ee17e9ea8a7a0abeb2a67d3f4023045df585eeee245d3d7c159635b00e2a8f669571116d16948012e87a97cfb7f71aa3dddd87f51d0aed91c9771a390dc9b61971f3dcf0c5fc3c53378723dd9d212750784672ae40daf0975357642e209d0a343158dbf1d9aba24e9f811b14dc641802b0d699b98120d112a596c99a0dd3d8faeec58cc872f757fe871492f2bace2eed363cfc3016aff964b5045cefbbcdbfe13fd9feaa690fcfd2215df41ffbeb2d512b248530499fa5e7b9b7eb6f0c07d4b553435e8d1c98dc9984782c403e6e237674f9636dfaf35d37f321b3a3f1a6f10380020e30cf35a6c2707fdd0f750f21f2f3fe5d4f9db8d88ccb6712810a567a214e60215b404ec23a3512d186574d2aa37334db3f08ace933f05a095f85e237d3cac06250c7b975e86575d6f3971c2d6a6abd7fe83b39dc7a5899cab340b01b1f27414ebe57d59353196ed514f15d05433bf0b2943a103dcef5de383a41083348e2dc519e294291ed401abaed51092c167a62ba895320b7eda22f82c0a77d0f1f8821369b5a0c5c032145132415bd2a1c50c977cbeb4cfabf3ff4b7dd9fef50821e0902ed09637f54605d65b0a1f6019a23996d8726ba528d3ff2cfb29bccdd7629f8cdf4d2c1bcc8a9fc5f2560ea080439ebee6d3cea4de43a85b1d9b7d22d93a1e5b3b32281c38d5647aeb7eb3c2406b6ccc2e0d98d22eec28fd23b829ab9d161eb0dcc5271821b8f6e3be8b18f016ff85f8b53a683ad2e67d9bccc3fcaab5219e5b7518d5c27cde426e1c76d88126e675ee8f0bfc624865abb8b7a6df903af98573e146602fd5bb4985a947e641d58fdfd5c2652abca177cc1408f67c6d30fd373f1c91043a57cc6c98b6f6367153f436bc9b1fb6793991c40fee206d9da69f1388c2f7ff659dbef5cd11b1608267c23b7e0b7ac0779ea5a12d83e47ab7b633444893450cb59407e14140dd4a1164e75baa706e7366126513542a4a5a31dbcafacaebaa5153c9d715302da1a2404841e6be30145f2cbf012f2faa98e631191c688b2adcf15d67a74e6017333271bcb68b0773ec68a4072a55a46ef0dbf4318945911ad2c44ccbc9ff63ac621d829884dc1b07053d84662ad4a4044b0d6e3eec3c5d03cd806159bf6bcba19041b06cec6aa2432fbaa3bb766ca0c148bfc01468035cb83a1b1deb2643316e845f1121f3382a35f56077c39d06e16f7625b8b741ae66276fcaf6a422fb7c1a5f62f2fe2b1cc0596bfb99ff1babc0ef6cb02800a1c0d6aebe2f00b6c23157f115af702f7704bac81e31895b95c64bdb66f7339efc85aa09c7edcd4676578736afa0d0a88bcb103afbc0ff1254be0e1bd46db5b0a831fc9a6ac0e47e117612b1e076f028dffd6e06e8e399202d8f5b9acc3db81b9ee29233d4725f20a0d53318f7cbc264183b8b72a7329f6559082324cb95f078a5e75bd1d09259563fa40f282ed4d1a15d7301164eee08e43a5b9e9ac6dcb3f394b1f40d2437d8988b0769eef4592221d6112606962b76db01ea8f9aa4308632ec28cf1ccdf4f0a4c148c40836b5d25cc7df4b3ab21bf286db774a266f78905942a4b9d72f802f65a47425111dce21a5737a32b3ef5fe4607e619195d2942ea2858f22ee93c52cd48cd291056258315b19fa454449c794e06c58159f2c6d0ac95f765bba08fd4d4a1dda32817eb3b23a2f04691b1a3ab4ddc1afa99a1e1fc735dcccfab7490cb2ef8bd71f910a35d1d85621b2709336b4ab5101d01629c72f7d9e8e8acc525b65c47ac4cb4e7c850213196479a89fb1d5f1e4189e81cc533c86837fb57c0d220ae38cbe0c6775afc0c2db06429cb0a55e2f7058cf467eaf663d33afae4e1ab7fa04fad181c338a5b24878c5e9c32a9bb1e560c04d5261c7f4ad4edca8e81693b9933923f3f65ebff0740ecfec2c211b14b1748fe4afa33cd5d139b10013799f8414e42d0a467ec18162bdf930511c461147503a22688065ae765b18c2b2baa4c96b6b9ec5af02e8e1dccf6563ea7d203f6ad949f538a45b7ffe5a844f27abba157ab10fb72a320e71283013f206de301a8843757264f79566cb1c5ad13baa0f7e7a4fc8c11e3a19705c0868b434179b2e04ed03807529e001e9cf071a14570f792594098c47c52b71ce0b17999d22d56317e3decf67134588ddbe9ca8f31c6b09ece615571c8366908ef363c97257e4b649e9810b44078046b24ac09b4685972d6f37876c05414540959177ea70eed539b6de18576b4dd365cc5b7d380bbe54a068f7e1c9e07cad1149f7d4dc6633e7634d9f447d31edf203a19ddddead3e2642979ea603fb118142fdfc869c2c8896ca87fc5aaf0acd0dd6350ee60325850d38f8bc01afce75b57215ce94d14ae6b48dadf0702898d6415de1c4dd22ed6ace670a04c821b42fbcb2e7be3eb86597da311e638bfebcb363f5ae27f52f85246150e98a119c9fc8cf7106e52449e49c60fe7a01ba407b029fd81f2c78f8fd2288436880b3a1c51711105df0098295ab2e7ee76389b87523bbdcc8e0c44de22c5b876038141834f84d701126a3c7c12f84aafe73ac92fdd68088938eb51fe90cbba3122675c20372dea20daa8d858e426cfc927850b8a9f9c4fdd9895df8ecef79a7061c570e4c581342edf20c1c06768896622d9ecb5258ba16c20ac1a9c5d7123e01defb39a0d8bc01dd79610e6377abe3449d5d1f502717130fade9628b28deeb9722768c1b53b1d0cd390ff1ff4b050372e29731fcea189cdadebe5ec41fec30184839f649d0ad026b44d897c15dbcdc190f7ecaa24d2a11b983b54d8a397eea8fc75f2c83542fe02133515785514238dc5917dbcf40b8289430aca0895e2db04df60c7f5b580a92b4b2ef25de1226d9ee36fc5f1dd661eeec801e7a38f5f3c06a8e0a55fb5035129d9b0ef2c1c962825d5579a5b871ea7c9104f28322aa1072e47f5a2f4af3bbd2b4f059b85b69c797d39f3f8f5948287f4626518d00a1ed3347506d78969aa99",
            0, // proposal ID
            1, // vote in favor
            0x00b698152e6728b3ac8d6a4f0465741afb38617dee54c60672038d483d0e7f7b // nullifier hash
        );
    }


    function test_Revert_DoubleVote() public {
        testValidVote();
        vm.expectRevert();
        voteContract.castVote(
            hex"257fc27753868d67f83891eebaebd03967d4ee17e9ea8a7a0abeb2a67d3f4023045df585eeee245d3d7c159635b00e2a8f669571116d16948012e87a97cfb7f71aa3dddd87f51d0aed91c9771a390dc9b61971f3dcf0c5fc3c53378723dd9d212750784672ae40daf0975357642e209d0a343158dbf1d9aba24e9f811b14dc641802b0d699b98120d112a596c99a0dd3d8faeec58cc872f757fe871492f2bace2eed363cfc3016aff964b5045cefbbcdbfe13fd9feaa690fcfd2215df41ffbeb2d512b248530499fa5e7b9b7eb6f0c07d4b553435e8d1c98dc9984782c403e6e237674f9636dfaf35d37f321b3a3f1a6f10380020e30cf35a6c2707fdd0f750f21f2f3fe5d4f9db8d88ccb6712810a567a214e60215b404ec23a3512d186574d2aa37334db3f08ace933f05a095f85e237d3cac06250c7b975e86575d6f3971c2d6a6abd7fe83b39dc7a5899cab340b01b1f27414ebe57d59353196ed514f15d05433bf0b2943a103dcef5de383a41083348e2dc519e294291ed401abaed51092c167a62ba895320b7eda22f82c0a77d0f1f8821369b5a0c5c032145132415bd2a1c50c977cbeb4cfabf3ff4b7dd9fef50821e0902ed09637f54605d65b0a1f6019a23996d8726ba528d3ff2cfb29bccdd7629f8cdf4d2c1bcc8a9fc5f2560ea080439ebee6d3cea4de43a85b1d9b7d22d93a1e5b3b32281c38d5647aeb7eb3c2406b6ccc2e0d98d22eec28fd23b829ab9d161eb0dcc5271821b8f6e3be8b18f016ff85f8b53a683ad2e67d9bccc3fcaab5219e5b7518d5c27cde426e1c76d88126e675ee8f0bfc624865abb8b7a6df903af98573e146602fd5bb4985a947e641d58fdfd5c2652abca177cc1408f67c6d30fd373f1c91043a57cc6c98b6f6367153f436bc9b1fb6793991c40fee206d9da69f1388c2f7ff659dbef5cd11b1608267c23b7e0b7ac0779ea5a12d83e47ab7b633444893450cb59407e14140dd4a1164e75baa706e7366126513542a4a5a31dbcafacaebaa5153c9d715302da1a2404841e6be30145f2cbf012f2faa98e631191c688b2adcf15d67a74e6017333271bcb68b0773ec68a4072a55a46ef0dbf4318945911ad2c44ccbc9ff63ac621d829884dc1b07053d84662ad4a4044b0d6e3eec3c5d03cd806159bf6bcba19041b06cec6aa2432fbaa3bb766ca0c148bfc01468035cb83a1b1deb2643316e845f1121f3382a35f56077c39d06e16f7625b8b741ae66276fcaf6a422fb7c1a5f62f2fe2b1cc0596bfb99ff1babc0ef6cb02800a1c0d6aebe2f00b6c23157f115af702f7704bac81e31895b95c64bdb66f7339efc85aa09c7edcd4676578736afa0d0a88bcb103afbc0ff1254be0e1bd46db5b0a831fc9a6ac0e47e117612b1e076f028dffd6e06e8e399202d8f5b9acc3db81b9ee29233d4725f20a0d53318f7cbc264183b8b72a7329f6559082324cb95f078a5e75bd1d09259563fa40f282ed4d1a15d7301164eee08e43a5b9e9ac6dcb3f394b1f40d2437d8988b0769eef4592221d6112606962b76db01ea8f9aa4308632ec28cf1ccdf4f0a4c148c40836b5d25cc7df4b3ab21bf286db774a266f78905942a4b9d72f802f65a47425111dce21a5737a32b3ef5fe4607e619195d2942ea2858f22ee93c52cd48cd291056258315b19fa454449c794e06c58159f2c6d0ac95f765bba08fd4d4a1dda32817eb3b23a2f04691b1a3ab4ddc1afa99a1e1fc735dcccfab7490cb2ef8bd71f910a35d1d85621b2709336b4ab5101d01629c72f7d9e8e8acc525b65c47ac4cb4e7c850213196479a89fb1d5f1e4189e81cc533c86837fb57c0d220ae38cbe0c6775afc0c2db06429cb0a55e2f7058cf467eaf663d33afae4e1ab7fa04fad181c338a5b24878c5e9c32a9bb1e560c04d5261c7f4ad4edca8e81693b9933923f3f65ebff0740ecfec2c211b14b1748fe4afa33cd5d139b10013799f8414e42d0a467ec18162bdf930511c461147503a22688065ae765b18c2b2baa4c96b6b9ec5af02e8e1dccf6563ea7d203f6ad949f538a45b7ffe5a844f27abba157ab10fb72a320e71283013f206de301a8843757264f79566cb1c5ad13baa0f7e7a4fc8c11e3a19705c0868b434179b2e04ed03807529e001e9cf071a14570f792594098c47c52b71ce0b17999d22d56317e3decf67134588ddbe9ca8f31c6b09ece615571c8366908ef363c97257e4b649e9810b44078046b24ac09b4685972d6f37876c05414540959177ea70eed539b6de18576b4dd365cc5b7d380bbe54a068f7e1c9e07cad1149f7d4dc6633e7634d9f447d31edf203a19ddddead3e2642979ea603fb118142fdfc869c2c8896ca87fc5aaf0acd0dd6350ee60325850d38f8bc01afce75b57215ce94d14ae6b48dadf0702898d6415de1c4dd22ed6ace670a04c821b42fbcb2e7be3eb86597da311e638bfebcb363f5ae27f52f85246150e98a119c9fc8cf7106e52449e49c60fe7a01ba407b029fd81f2c78f8fd2288436880b3a1c51711105df0098295ab2e7ee76389b87523bbdcc8e0c44de22c5b876038141834f84d701126a3c7c12f84aafe73ac92fdd68088938eb51fe90cbba3122675c20372dea20daa8d858e426cfc927850b8a9f9c4fdd9895df8ecef79a7061c570e4c581342edf20c1c06768896622d9ecb5258ba16c20ac1a9c5d7123e01defb39a0d8bc01dd79610e6377abe3449d5d1f502717130fade9628b28deeb9722768c1b53b1d0cd390ff1ff4b050372e29731fcea189cdadebe5ec41fec30184839f649d0ad026b44d897c15dbcdc190f7ecaa24d2a11b983b54d8a397eea8fc75f2c83542fe02133515785514238dc5917dbcf40b8289430aca0895e2db04df60c7f5b580a92b4b2ef25de1226d9ee36fc5f1dd661eeec801e7a38f5f3c06a8e0a55fb5035129d9b0ef2c1c962825d5579a5b871ea7c9104f28322aa1072e47f5a2f4af3bbd2b4f059b85b69c797d39f3f8f5948287f4626518d00a1ed3347506d78969aa99",
            0, // proposal ID
            1, // vote in favor
            0x00b698152e6728b3ac8d6a4f0465741afb38617dee54c60672038d483d0e7f7b // nullifier hash
        );
    }
}
